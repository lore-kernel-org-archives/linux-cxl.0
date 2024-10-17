Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD411386B4
	for <linux-cxl@vger.kernel.org>; Thu, 17 Oct 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178863; cv=none; b=hXfSwJpM0Ik+5oA3Er6ipJwSEigFHYodzt8lQmnOvt2I3l3ONMq1WzCZXgRb66ScSEhmoJChhWXIHZI6SOYLsNNFj2pMTPIVHMvNkzVPZhuTDEpHisP+8KkJOscxfpeh90k5gfIdddMsv4oXZ8K+5/A5Vx50jamWT9d7NElVKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178863; c=relaxed/simple;
	bh=w5rVZwulloejsadIdyaLY6fjkvSzU8XU7RGr+thvSMk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sp0PF4sKA3LDZRsaw122tVsQdP9+L2pnb4afPs5zDKjA8U9wVOzIqlqWnTgwIHXJCtrE+Y+SOaT2MA6Q9FJWNpQSUDyN9tOjsfht5BO35+0hBzj0EVPcHF4LUgGrUugptGOsoJIn9hKkPPPAyVnyRoU5wl3h8a+urtnsd1ZS3zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTs6G4bsHz6D9Z0;
	Thu, 17 Oct 2024 23:23:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F1721400F4;
	Thu, 17 Oct 2024 23:27:34 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 17:27:33 +0200
Date: Thu, 17 Oct 2024 16:27:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ravis OpenSrc <Ravis.OpenSrc@micron.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, Ajay Joshi
	<ajayjoshi@micron.com>
Subject: Re: [RFC PATCH v2 1/4] cxl: Enable mailbox ops with background only
 if request abort operation is supported.
Message-ID: <20241017162731.000034bf@Huawei.com>
In-Reply-To: <6e6cc093f70442e792c05e779393442a@micron.com>
References: <20241015205633.127333-1-ravis.opensrc@micron.com>
	<20241015205633.127333-2-ravis.opensrc@micron.com>
	<6e6cc093f70442e792c05e779393442a@micron.com>
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

On Wed, 16 Oct 2024 04:59:56 +0000
Ravis OpenSrc <Ravis.OpenSrc@micron.com> wrote:
Hi Ravi,

Change the author in git with
git commit --amend --author=3DRavi Shankar <ravis.opensrc@micron.com>

Then when you do git format-email or similar ti
will add an explicit
From: Ravi Shankar <ravis.opensrc@micron.com>
To the top of the patch description that git will then pick up
as the author.

> Enabling mailbox commands only if background operation and
> request abort cancellation are both supported.

Key here is the userspace access point.  We let the kernel
use these commands if it wants to as it can pick up the
pieces.

>=20
> This check is to allow user space commands to initiate
> background commands responsibly while complying with any
> default background timeout implemented in kernel.
>=20
> Link:
> https://lore.kernel.org/linux-cxl/66035c2e8ba17_770232948b@dwillia2-xfh.j=
f.intel.com.notmuch/
This is a tag just like the ones below.
So all on one line and no blank lines before the tag block.
>=20
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ajay Joshi <ajay.opensrc@micron.com>

What was Ajay's role in this?
Maybe a Co-developed tag is appropriate?

> Signed-off-by: Ravi Shankar <ravis.opensrc@micron.com>
> ---
> =A0drivers/cxl/core/mbox.c | 12 ++++++++++--
> =A0drivers/cxl/cxlmem.h=A0=A0=A0 | 16 ++++++++++++++++
> =A02 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 5175138c4fb7..8c0144913b9e 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -733,12 +733,20 @@ static void cxl_walk_cel(struct cxl_memdev_state *m=
ds, size_t size, u8 *cel)
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < cel_entries; i++) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u16 opcode =3D le16_to_c=
pu(cel_entry[i].opcode);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u16 effect =3D le16_to_cpu(ce=
l_entry[i].effect);
Your email client has I think mangled this to use spaces instead of tabs.

Given the fun that is corporate email systems, maybe take a look at
using b4 and the webproxy that allows patches to be sent to the mailing
list without involving any company email servers :)

> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct cxl_mem_command *=
cmd =3D cxl_mem_find_command(opcode);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int enabled =3D 0;
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cmd) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_b=
it(cmd->info.id, mds->enabled_cmds);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabl=
ed++;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
For background operation commands, enable only if
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * =
Request abort background operation is supported.
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!=
(effect & CXL_CEL_FLAG_BACKGROUND_OPERATION) ||
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (effect & CXL_CEL_FLAG_REQ_ABORT_BACKGROUND_SUPPORTED)) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 set_bit(cmd->info.id, mds->enabled_cmds);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 enabled++;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cxl_is_poison_comman=
d(opcode)) {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 2a25d1957ddb..d8c0894797ac 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -579,6 +579,22 @@ struct cxl_cel_entry {
> =A0=A0=A0=A0=A0=A0=A0=A0 __le16 effect;
> =A0} __packed;
> =A0
> +/*
> + * CEL Entry Effects
> + * CXL rev 3.1 Section 8.2.9.5.2.1; Table 8-75
> + */
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_AFTER_RESET BIT(0)

AFTER_COLD_RESET (subtle but we should include the COLD)

> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_IMMEDIATE BIT(1)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_DATA_CHANGE_IMMEDIATE BIT(2)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_POLICY_CHANGE_IMMEDIATE BIT(3)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_LOG_CHANGE_IMMEDIATE BIT(4)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_SECURITY_CHANGE BIT(5)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_BACKGROUND_OPERATION BIT(6)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_SECONDARY_MAILBOX_SUPPORTED BI=
T(7)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_REQ_ABORT_BACKGROUND_SUPPORTED=
 BIT(8)
Should define the fun of bit 9 which is kind of a cheeky version
bit hiding in here that says if we should pay attention to next tow
or have no idea.

> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_AFTER_CONV_RESET BI=
T(10)
> +#define=A0=A0=A0=A0=A0=A0=A0 CXL_CEL_FLAG_CFG_CHANGE_AFTER_CXL_RESET BIT=
(11)
> +
> =A0struct cxl_mbox_get_log {
> =A0=A0=A0=A0=A0=A0=A0=A0 uuid_t uuid;
> =A0=A0=A0=A0=A0=A0=A0=A0 __le32 offset;

