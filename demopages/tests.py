from django.test import TestCase, Client


class IndexTestCase(TestCase):
    def setUp(self) -> None:
        self.client = Client()


    def test_get_index_endpoint(self):
        response = self.client.get('/')
        self.assertEquals(response.status_code, 200)
        self.assertEquals(response.content, b'Hello World')

# Create your tests here.

