Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F51DFE25
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179371; cv=none; b=uSB1l0oaO2gyP+N9Gk9Bjn0PU4LKt4kCuyVdTNf9NLGM+J0Biahqu3eS/Xg+TJBihTATJt0hX1Hxko5QyY62iJ0U0LapgizonUnzpEpxv8WFZUa7Iu1onTSFplqhOpKYjrvUwgyqRcnkBtJtSmfnmKVfp66E/GcutPjL3ahHQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179371; c=relaxed/simple;
	bh=f9FYJevAi/w47QFAfdQtgrKA4EFp3lUKgSieefI6DWo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYnu//8O1s6GrJ7IvQABUoIar61DNVuelOJs8N9QIKfldr+ypRUOu0BQvFx+kVU4bG9ihWgYJPStsxmIMH3kP2zfPZF0mow6K74Gl5i+kWMkHi6TI22bsKTtxfClG6y+JTQdvJ5U9YaiHwrdl6u4b9BhhfMtJF/Xx9v07OhHTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTsNW3FYxz6HJg5;
	Thu, 17 Oct 2024 23:35:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F480140A46;
	Thu, 17 Oct 2024 23:36:04 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 17:36:03 +0200
Date: Thu, 17 Oct 2024 16:36:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Ajay Joshi
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH v2 3/4] cxl: Abort background operation in case of
 timeout
Message-ID: <20241017163601.00002a1a@Huawei.com>
In-Reply-To: <00a0aa82ae12450a8c690e11440c4101@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-4-ravis.opensrc@micron.com>
	<00a0aa82ae12450a8c690e11440c4101@micron.com>
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

On Wed, 16 Oct 2024 05:00:00 +0000
Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:

> Adding support for aborting timed out background operations
>=20
> CXL r3.1 8.2.9.1.5 Request Abort Background Operation.
>=20
> If the status of a mailbox command is identified as timedout,
> an abort background operation request is sent to the device.
>=20
> Link:
> https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.j=
f.intel.com.notmuch/
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>

I was kind of expecting that we'd do this more on an ondemand
basis. So if nothing is going on, the command can have ages.
If the kernel wants to access the device and it has had a
reasonable amount of time we abort.

I'm not against this simpler approach though if it turns out
to be good enough for likely use cases.

My worry is error paths crossing with a slow command where
we want to find out what went wrong as quick as possible
Is 5 seconds ok for that?  Maybe not.

Jonathan

> ---
> =A0drivers/cxl/cxlmem.h |=A0 1 +
> =A0drivers/cxl/pci.c=A0=A0=A0 | 11 +++++++++++
> =A02 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index d8c0894797ac..808fb8712145 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -516,6 +516,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
> =A0enum cxl_opcode {
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_INVALID=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 0x0000,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_RAW=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D CXL_MBOX_OP_INVALID,
> +=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION=A0=A0=A0 =
=3D 0x0005,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_EVENT_RECORD=A0=A0=A0 =3D 0x0100,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_CLEAR_EVENT_RECORD=A0 =3D 0x0101,
> =A0=A0=A0=A0=A0=A0=A0=A0 CXL_MBOX_OP_GET_EVT_INT_POLICY=A0 =3D 0x0102,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d5d6142f6aa3..95c1f329bca2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -394,6 +394,17 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl=
_mbox,
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 mutex_lock_io(&cxl_mbox->mbox_mutex);
> =A0=A0=A0=A0=A0=A0=A0=A0 rc =3D __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
> +=A0=A0=A0=A0=A0=A0 if (rc =3D=3D -ETIMEDOUT &&
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cmd->return_code =3D=3D CXL_M=
BOX_CMD_RC_BACKGROUND) {

align cmd just after ( - that is c is under the r of rc
After fixing the tabs thing.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cxl_mbox_cmd abort_cmd=
 =3D {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .opco=
de =3D CXL_MBOX_OP_REQ_ABRT_BACKGROUND_OPERATION
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 };
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D __cxl_pci_mbox_send_cm=
d(cxl_mbox, &abort_cmd);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!rc)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =
=3D -ECANCELED;
> +=A0=A0=A0=A0=A0=A0 }
> +
> =A0=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&cxl_mbox->mbox_mutex);
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 return rc;

