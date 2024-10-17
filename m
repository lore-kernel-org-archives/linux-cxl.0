Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F311DE3B1
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179449; cv=none; b=eqfsSnTdZHmSN/c3cEEjeyRG1bVlHIQyh1+E+Q0No4+bHJGcl7UX4q/0jOiW3YJnWIsNW+T55N9KXDjipQkbZRDSHleiNVTWdtPRfsf4LGsS6pgMyqhuk8gGJ2bqYOafVQXJQuw6JWupZPpg4sE42T6nHwxFsPdxib7QnFvQYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179449; c=relaxed/simple;
	bh=SEfxQSB/gtz1lFdja5Ewh0QPq0PT1EYHYwyjx1nYtA8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iubyYIHuyi/uU6LA9YQFZMpZuZKdP1hm0yR6RjcbN4gUxag35Kschv3rztYiXmHmNLaWKyDlpy80uUOfA7AQxaEQxQVbWFNtgRI8tLYaW/3/HST10MqdqzFfOq4/UfF7JM1gPz3OTNMmVu+5BWHCCeTsqI6axoHq/rjGgJNNHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTsKY63hgz6D9Hf;
	Thu, 17 Oct 2024 23:32:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 934F9140113;
	Thu, 17 Oct 2024 23:37:21 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 17:37:21 +0200
Date: Thu, 17 Oct 2024 16:37:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Ajay Joshi
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH v2 4/4] cxl/mbox: Add Populate Log support
Message-ID: <20241017163719.0000708b@Huawei.com>
In-Reply-To: <d37a0cc0e3d847afa0ef87b1fbab34de@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-5-ravis.opensrc@micron.com>
	<a67bf703fe3f4e9c8d1d8588d734d2b0@micron.com>
	<d37a0cc0e3d847afa0ef87b1fbab34de@micron.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 05:00:02 +0000
Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:

> Adding UAPI support for
> =A0CXL r3.1 8.2.9.5.5 Populate Log.
>=20
> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
hmm. Exciting threading ;) Definitely want to sort
that out for future postings.

Other than formatting this looks ok to me.

Jonathan

> ---
> =A0drivers/cxl/core/mbox.c=A0=A0=A0=A0=A0 | 1 +
> =A0drivers/cxl/cxlmem.h=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
> =A0include/uapi/linux/cxl_mem.h | 1 +
> =A03 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 8c0144913b9e..48c2fc8b4bcd 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -59,6 +59,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_=
COMMAND_ID_MAX] =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_LOG_CAPS, 0x10, 0x4, 0),
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(CLEAR_LOG, 0x10, 0, 0),
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_SUP_LOG_SUBLIST, 0x2, CXL_VARIABLE_P=
AYLOAD, 0),
> +=A0=A0=A0=A0=A0=A0 CXL_CMD(POPULATE_LOG, 0x10, 0, 0),
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(SET_LSA, CXL_VARIABLE_PAYLOAD, 0, 0),
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 808fb8712145..6320d8cd3ca3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -530,6 +530,7 @@ enum cxl_opcode {
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_LOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 0x0401,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_LOG_CAPS=A0=A0=A0=A0=A0=A0=A0 =
=3D 0x0402,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_CLEAR_LOG=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 =3D 0x0403,
> +=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_POPULATE_LOG=A0=A0=A0=A0=A0=A0=A0 =3D 0x0=
404,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_SUP_LOG_SUBLIST =3D 0x0405,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_IDENTIFY=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 0x4000,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_PARTITION_INFO=A0 =3D 0x4100,
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c6c0fe27495d..040ca37046ed 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -50,6 +50,7 @@
> =A0=A0=A0=A0=A0=A0=A0=A0 ___C(GET_LOG_CAPS, "Get Log Capabilities"),=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> =A0=A0=A0=A0=A0=A0=A0=A0 ___C(CLEAR_LOG, "Clear Log"),=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \
> =A0=A0=A0=A0=A0=A0=A0=A0 ___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Su=
b-List"),=A0=A0=A0=A0=A0=A0=A0=A0 \
> +=A0=A0=A0=A0=A0=A0 ___C(POPULATE_LOG, "Populate Log"),=A0=A0=A0=A0=A0=A0=
 \
> =A0=A0=A0=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")
> =A0
> =A0#define ___C(a, b) CXL_MEM_COMMAND_ID_##a

