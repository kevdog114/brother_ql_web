FROM python:3.10-alpine

WORKDIR /usr/src/app

RUN apk add --update --no-cache \
    fontconfig \
	py3-pillow \
	py3-future \
	py3-jinja2 \
	py3-bottle \
	libdmtx \
	libdmtx-dev \
	libdmtx-libs \
	ttf-dejavu

COPY brother_ql_web/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN ln -s /usr/lib/libdmtx.so /usr/local/lib/libdmtx.so
RUN ln -s /usr/lib/libdmtx.so.0 /usr/local/lib/libdmtx.so.0

COPY ./brother_ql_web/ .

CMD [ "python", "./brother_ql_web.py", "--model", "QL-700", "--default-label-size", "23x23", "file:///dev/usb/lp0" ]

