Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D826AEC
	for <linux-cxl@vger.kernel.org>; Wed,  9 Oct 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728443365; cv=pass; b=ZcHWmko8CM7+s1qRN5C/s3BdezBMyTpZTi8rqIRcUm5yC5oIyXtQkvgH+wWvghQdSCzA6Gk1uR2HW4Z2ldlHTUJjKGRklWNPSF1KXpxr00ixiUfxxmtg73Y/XT+JVhe19YNAFwkGuGosvBPrUpgiPzpMrtY6SRerd6zrfEMWA4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728443365; c=relaxed/simple;
	bh=PYXbNs5vuFMHAXEourj3viaNtVFIQVKHYMS1thj60kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSV4G6ZsnYJvpTVFQWnXCQhcmM2Z0l1yGqXvetogRiecw5Hb+V1OttQQrFJtoFTW/rhbAxNd1lGEFtJFObpIheUB4zJAWhaCamcIrvx82eq1nicrXeulcUyzfTz5TPdHcGoTzITazMW5PK9Ls5eXX07pCBT6QNZPvjjNjg83DZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=btZyemQM; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="btZyemQM"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 679A290526F;
	Wed,  9 Oct 2024 03:03:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a279.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.101.173.103])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 04556905372;
	Wed,  9 Oct 2024 03:03:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1728442989; a=rsa-sha256;
	cv=none;
	b=vrmbO4+aGyPTOk2YnpgYQ5RkS5KTPWaLeBzhSGYiiPSwbN/yGE6YifIyPhSR0NKCT8eTqA
	CkLEkJdCsPiqmZEHAqk4S4eCOQqYdoqtPwQIrJ3f+KPmR5sCE98IdsI+zAUBLTGPqTlujh
	1eHhL1IXu56f7tnX6fEpBRit04E3Q1cIS9CZd0wqDr4iRpK3bs4/LVCi2302yxj962kjge
	6KcBzmdL9trExmkf56VBv25AzHBHKabkeqHgGtLZajJVfnxaqLuQyAoaAVo2YfdUtR83Zp
	juFv3xmBCTqHnw3ReczJypqmb4bGq9nuD4ch8QzP+EhLLzhrnjU6w36oTACaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1728442989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zuqFRnQ5g+78gWUtlFavQ9YtvH2+ssaWeobdd16OhFA=;
	b=YWk7Az6c5rwH6ug0pCQEdbtKFetF/recpOoLcUbuVXX0Dq6Lgw9eYQK5qUqIuH/cLGVA0D
	Vj0ogKHqQsXDCffbeg/dkqU94E3DoyTCUxR9ALtCGmGi7+hQ4l9e4FeLrpplLdtZuJO4vP
	FmpowHnYLN1XF5IpklMM3y94aGaufAYK1Gj3erO2tl+JfUYLaOlBaA/IxNnyPNoE9RNRDn
	au70uueJDmuVTiBv479NvSMuQ03rRKrDPZm3e5KkKW1Mn9A6XeEuNC7pm+ojIN5wCnq00k
	X5/I/uuTzNls/cz7eNawnvgLMpRd8XXpitIGNgfn+n6tj3yqJ59vHVLdhociJQ==
ARC-Authentication-Results: i=1;
	rspamd-54f99b5bc4-82m9t;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cold-Invention: 170c03b82291bff0_1728442989287_1477917783
X-MC-Loop-Signature: 1728442989287:1068372020
X-MC-Ingress-Time: 1728442989287
Received: from pdx1-sub0-mail-a279.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.173.103 (trex/7.0.2);
	Wed, 09 Oct 2024 03:03:09 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a279.dreamhost.com (Postfix) with ESMTPSA id 4XNd4D22Nyz2q;
	Tue,  8 Oct 2024 20:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1728442988;
	bh=zuqFRnQ5g+78gWUtlFavQ9YtvH2+ssaWeobdd16OhFA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=btZyemQMhHeJllCxNHLhlK1U98FOZK+AUg1Yr9haUrykf98YaejhHUJ9c0e36MkDw
	 cW/+6ApTC7cCLvbTUudT1PS/E4Dd/69BU7/SkEk2vF+webrw063F11a6ByD7KqvD+x
	 377HhVhehFi2ofAL+irL+XZcdoPoTlV8TVc2KetMaH5kVpO5dYO3O2JogWv7uwsuhO
	 uP7hVyZcnJ7sdwvUG1pgewDah56+qP4F8tuCHeye4Nujaye2alhHepFKQvviwhP5Qa
	 qlKYHdjX0bl9NkjzLDxb1DRLv0omUIsHC7VtLuhMGmfh3y9Zf0VfNo2W9mn3plLK3s
	 D44Pqnti3Sk0A==
Date: Tue, 8 Oct 2024 20:01:07 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com, 
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com, nmtadam.samsung@gmail.com, 
	abhi.n@samsung.com, alok.rathore@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [QEMU PATCH] cxl/cxl-mailbox-utils: Fix size check for
 cmd_firmware_update_get_info
Message-ID: <uuxiowlqgqs7mq2dfxixw4ryx4zfbygyaji7axfcln3nstdfed@nufwcfs2nj2a>
References: <20241008164624.78608-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241008164624.78608-1-nifan.cxl@gmail.com>
User-Agent: NeoMutt/20240425

On Tue, 08 Oct 2024, nifan.cxl@gmail.com wrote:\n
>From: Fan Ni <fan.ni@samsung.com>
>
>In the function cmd_firmware_update_get_info for handling Get FW info
>command (0x0200h), the vmem, pmem and DC capacity size check were
>incorrect. The size should be aligned to 256MiB, not smaller than
>256MiB.

Can get rid of a level of parenthesis (other cmds as well), otherwise:

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Signed-off-by: Fan Ni <fan.ni@samsung.com>
>---
> hw/cxl/cxl-mailbox-utils.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
>index 9258e48f95..c82ad50ac8 100644
>--- a/hw/cxl/cxl-mailbox-utils.c
>+++ b/hw/cxl/cxl-mailbox-utils.c
>@@ -649,9 +649,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>     } QEMU_PACKED *fw_info;
>     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
>
>-    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
>-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
>-        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
>+    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
>+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
>+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
>         return CXL_MBOX_INTERNAL_ERROR;
>     }
>
>--
>2.43.0
>
