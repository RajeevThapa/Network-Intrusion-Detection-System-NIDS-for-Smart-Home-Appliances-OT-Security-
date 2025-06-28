# smartplug_vuln.py
import asyncio
from aiocoap import resource, Context, Message, Code

# Simulated smart plug state
smart_plug_state = {"power": "off"}

class VulnerableSmartPlugResource(resource.Resource):
    async def render_post(self, request):
        try:
            # BAD: Unsafe eval on user input (command injection vuln)
            payload = request.payload.decode("utf-8")
            result = eval(payload)  # For example: 'smart_plug_state["power"] = "on"'
            response = f"Executed: {payload} -> {smart_plug_state}"
        except Exception as e:
            response = f"Error: {e}"
        return Message(payload=response.encode("utf-8"))

    async def render_get(self, request):
        return Message(payload=str(smart_plug_state).encode("utf-8"))

def main():
    # CoAP context
    root = resource.Site()
    root.add_resource(['plug'], VulnerableSmartPlugResource())
    asyncio.Task(Context.create_server_context(root))
    asyncio.get_event_loop().run_forever()

if __name__ == '__main__':
    main()
