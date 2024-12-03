Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3231F8AD4;
	Tue,  3 Dec 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240513; cv=none; b=clwHYYWSGuFl27VbE7xceg0kIqzHd8pt9uP/gxL6Vlf34gOggZw2zyfpUC93Lc89CEZpFviYLcHCdKayvS/EqiZqM0HYEtWx0MfW4q4BxxFAC8GJ7fsxSwDHV9z/uW/NhGiei+sK4Dt561MfSZU3qe5lxeZeoBInVSijjeaTAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240513; c=relaxed/simple;
	bh=vsJYp3o9xBnk5BZ2+j/Ak9wF0vvUADAk/LxRCPfyTlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=STrizW9S1dU/QhmIoFjiIIq6OeD8DJGyVD6zkOZk4X+0tpj/5ukSRJZ5JIIwo+jj0rE12D4I7mRDUsvDFuUr5x7D+kIB+QNM0fd9bxZzp7fGpL8zR5RJ2Tep1ULLltUjkRGTqHkPyrXbYeYTDyomdbLQHZqCEiRCRKYJO8rA8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y2krF6872z6LDG0;
	Tue,  3 Dec 2024 23:21:01 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
	by mail.maildlp.com (Postfix) with ESMTPS id 69051140CB9;
	Tue,  3 Dec 2024 23:21:44 +0800 (CST)
Received: from frapeml500007.china.huawei.com (7.182.85.172) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Dec 2024 16:21:44 +0100
Received: from frapeml500007.china.huawei.com ([7.182.85.172]) by
 frapeml500007.china.huawei.com ([7.182.85.172]) with mapi id 15.01.2507.039;
 Tue, 3 Dec 2024 16:21:44 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "dave.jiang@intel.com" <dave.jiang@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [PATCH v4 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Thread-Topic: [PATCH v4 3/6] cxl/events: Update General Media Event Record to
 CXL spec rev 3.1
Thread-Index: AQHbOy/jEKs9N8Ou/EWSGme10Yml3rLJc4IQgABPV4CAAS95QIAATDQAgAA1zlD///prgIABEYyggAHA21CABm0UcA==
Date: Tue, 3 Dec 2024 15:21:44 +0000
Message-ID: <e4187844aed14d4897f0071dcfce7455@huawei.com>
References: <20241120093745.1847-1-shiju.jose@huawei.com>
	<20241120093745.1847-4-shiju.jose@huawei.com>
	<180fcfd623c64cdb86cdc9059f749af0@huawei.com>
	<20241126120237.1598854d@gandalf.local.home>
	<a24524dccbf442d5a3c910d7f46c7b6c@huawei.com>
	<20241127104132.6c1729e1@gandalf.local.home>
	<53a299d3cca6417d90d553e8399f834b@huawei.com>
 <20241127133407.7bc1376a@gandalf.local.home>
 <dc8fa73e871949eeaf4117c622d66ac5@huawei.com>
 <3c9808a694d242cab35bab67602edebf@huawei.com>
In-Reply-To: <3c9808a694d242cab35bab67602edebf@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>-----Original Message-----
>From: Shiju Jose <shiju.jose@huawei.com>
>Sent: 29 November 2024 13:23
>To: Shiju Jose <shiju.jose@huawei.com>; Steven Rostedt <rostedt@goodmis.or=
g>
>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=
;
>Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>Zengtao (B) <prime.zeng@hisilicon.com>
>Subject: RE: [PATCH v4 3/6] cxl/events: Update General Media Event Record =
to
>CXL spec rev 3.1
>
>>-----Original Message-----
>>From: Shiju Jose <shiju.jose@huawei.com>
>>Sent: 28 November 2024 10:02
>>To: Steven Rostedt <rostedt@goodmis.org>
>>Cc: dave.jiang@intel.com; dan.j.williams@intel.com; Jonathan Cameron
>><jonathan.cameron@huawei.com>; alison.schofield@intel.com;
>>nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>>dave@stgolabs.net; linux-cxl@vger.kernel.org;
>>linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
>>tanxiaofei <tanxiaofei@huawei.com>; Zengtao (B)
>><prime.zeng@hisilicon.com>
>>Subject: RE: [PATCH v4 3/6] cxl/events: Update General Media Event
>>Record to CXL spec rev 3.1
>>
[...]
>
>Hi Steve,
>
>I debug this case and please find the info, 1. rasdaemon :  read() from fo=
rmat
>file return around 1/3rd of the
>    actual data in the file only when the total size of the format's file
>    is above 4K bytes (page size), For example, in this case, the total si=
ze was 4512
>bytes,
>    but read only 1674 bytes.
>    This partial data resulted  tep_parse_event() in libtraceevent failed =
internally
>in the parse_format()
>    and  since __parse_event() does not return error when parse_format() f=
ail,
>    thus initialization of the event does not fail.
>
>   The following  solution in rasdaemon solved the issue,
>   (provided if no other fix for the above issue with read()),
>    1. read() and accumulate content of format file until EOF reached.
>    2. Increased the buffer size from 4K bytes to  8K bytes.
>    3. May be __parse_event()  in libtraceevent  and thus tep_parse_event(=
)
>return error
>        when parse_format() fail so that the initialization would fail if =
the input
>data is
>        corrupted or partial?

Hi Steve,

Identified the root cause of this issue in the kernel:
The read() function for the event's format file calls seq_read() and seq_re=
ad_iter() in the kernel,=20
which allocates a buffer of PAGE_SIZE (4 KB) for sequential reads. However,=
 it
detects an overflow in the following marked call (seq_has_overflowed()) and=
=20
returns with partial data read.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

File : https://elixir.bootlin.com/linux/v6.13-rc1/source/fs/seq_file.c

ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
{
	struct seq_file *m =3D iocb->ki_filp->private_data;
[...]
	/* grab buffer if we didn't have one */
	if (!m->buf) {
--------->		m->buf =3D seq_buf_alloc(m->size =3D PAGE_SIZE);
		if (!m->buf)
			goto Enomem;
	}
	// something left in the buffer - copy it out first
[...]
	// get a non-empty record in the buffer
	m->from =3D 0;
	p =3D m->op->start(m, &m->index);
	while (1) {
		err =3D PTR_ERR(p);
		if (!p || IS_ERR(p))	// EOF or an error
			break;
[...]
	}
	// EOF or an error
	m->op->stop(m, p);
	m->count =3D 0;
	goto Done;
Fill:
	// one non-empty record is in the buffer; if they want more,
	// try to fit more in, but in any case we need to advance
	// the iterator once for every record shown.
	while (1) {
		size_t offs =3D m->count;
		loff_t pos =3D m->index;

[...]
		err =3D m->op->show(m, p);
		if (err > 0) {		// ->show() says "skip it"
			m->count =3D offs;
---------->	} else if (err || seq_has_overflowed(m)) {
			m->count =3D offs;
			break;
		}
	}
	m->op->stop(m, p);
	n =3D copy_to_iter(m->buf, m->count, iter);
	copied +=3D n;
	m->count -=3D n;
	m->from =3D n;
Done:
[...]
	goto Done;
}
EXPORT_SYMBOL(seq_read_iter);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The following fix in the kernel's seq_read_iter() allows userspace to read =
the
content of the format file etc in one go if the requested size exceeds PAGE=
_SIZE,
and resolves the parsing error caused by the event's format file exceeding =
PAGE_SIZE.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/fs/seq_file.c b/fs/seq_file.c index e676c8b0cf5d..f1f1af180562=
 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -207,7 +207,11 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_i=
ter *iter)
=20
        /* grab buffer if we didn't have one */
        if (!m->buf) {
-               m->buf =3D seq_buf_alloc(m->size =3D PAGE_SIZE);
+               if (iter->count % PAGE_SIZE)
+                       m->size =3D ((iter->count / PAGE_SIZE) + 1) * PAGE_=
SIZE;
+               else
+                       m->size =3D (iter->count / PAGE_SIZE) * PAGE_SIZE;
+                m->buf =3D seq_buf_alloc(m->size);
                if (!m->buf)
                        goto Enomem;
        }
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can you suggest which fix is the right one,  kernel based fix or rasdaemon =
based fix (which
mentioned in the previous email)?=20

Thanks,
Shiju
>>
>>>
>>>>
>>>> I've also attached another format file,
>>>> "format_cxl_general_media_v3.1_full",
>>>> which contains the complete TP_printk() intended.
>>>
[...]
>>>-- Steve
>>
>
