Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44A1DED58
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179145; cv=none; b=Z8mzJ7gNMRMMH6Ps7UU912dKft+GcsSnffE21Cw6rcl8N/kgcJ5D+uq0u+vVIbn184See216Zmdq3Ayovxj/M6xGh71mCIVv1CIu1rhE6FoGWhG+KJ/DE2wFVrDXPtk/VVd6v2KvzR9ARhS0PvLMJRY5qU/D2E5PcvHS7wvKcmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179145; c=relaxed/simple;
	bh=38Fvif5tA82D4yXzhM/xOZU8k7cuYdIYGrXdyF+Ukvs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joFC14OTrtM0xZTZQyYBqWnOcO7GKtTNyNwueBfK3+Ak75a9mSFOR0PWRTmDTrBDO/AYxN0tLJsDGKrz6WbS0tc2fE5pL+viJoDd0iNqurRtnlnDAQjV3nNT5xJLyG4yuqIB1PrUI4TMW3gjq9zl0AsQOkmb7o3l66uoR/QsvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTsJ916wDz6HJdr;
	Thu, 17 Oct 2024 23:31:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B86691400F4;
	Thu, 17 Oct 2024 23:32:17 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 17:32:17 +0200
Date: Thu, 17 Oct 2024 16:32:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Ajay Joshi
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH v2 2/4] cxl: Add default timeout for bg mailbox
 commands
Message-ID: <20241017163215.00000547@Huawei.com>
In-Reply-To: <913b851a25344bb1832ddc902eb0aa5f@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-3-ravis.opensrc@micron.com>
	<913b851a25344bb1832ddc902eb0aa5f@micron.com>
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

On Wed, 16 Oct 2024 04:59:58 +0000
Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:

> Allows 5s wait when no timeout parameter is explicitly mentioned.
>=20
> It is useful for mailbox commands to be executed in background
> when initiated from userspace.
>=20
> Link:
> https://lore.kernel.org/linux-mm/20240215123410.00003b8c@Huawei.com/T/
>=20
> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>
> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
Other than patch formatting, this seems reasonable to me.

Jonathan

> ---
> =A0drivers/cxl/pci.c | 13 +++++++++++++
> =A01 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 188412d45e0d..d5d6142f6aa3 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -41,6 +41,10 @@
> =A0/* CXL 2.0 - 8.2.8.4 */
> =A0#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
> =A0
> +/* Default timeout for background operations */
> +#define CXL_BG_POLL_CNT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 5
> +#define CXL_BG_POLL_INTERVAL_MS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 1000
> +
> =A0/*
> =A0 * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
> =A0 * dictate how long to wait for the mailbox to become ready. The new
> @@ -317,6 +321,15 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbo=
x *cxl_mbox,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(dev, "Mailbox ba=
ckground operation (0x%04x) started\n",
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
mbox_cmd->opcode);
> =A0
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Add a default timeout of=
 5 seconds when background operation
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * starts but no timeout is=
 specified.
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!mbox_cmd->poll_interval_=
ms) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mbox_=
cmd->poll_interval_ms =3D CXL_BG_POLL_INTERVAL_MS;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mbox_=
cmd->poll_count =3D CXL_BG_POLL_CNT;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> +
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 timeout =3D mbox_cmd->po=
ll_interval_ms;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < mbox_c=
md->poll_count; i++) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,

