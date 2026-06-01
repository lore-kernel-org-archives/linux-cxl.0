Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773E30C34A
	for <linux-cxl@vger.kernel.org>; Mon,  1 Jun 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331897; cv=none; b=h+lB/Nf0be6ajOWdBty+dzNf5UgykZZZvcZjD6udtTAxqMh2yUTY//2zQF3jfTpAtXOgD+t6WFXybI181YgKzY1tywzNKua4ZJiBc5aIeQ+ybjrWsILWktLRxTkhFtei3wGvPIIhrNXEQBMdtrtoiTOb+cBSZ2nGBW87kGT25oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331897; c=relaxed/simple;
	bh=X2G5G0un9mat/jYFVK4g5WEZ/xtz+iRyCon1ficbBnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwU0t7w4yv6npQiUbCAATEjd4KJoy5lykh8+i+QtoyeKglKiA0MY3fbvkdin2+WTEzNmPDwK6dKk9lQIJ4karvR7CF3dpcn+f4MmWmV2IcZ+eOAq534FSuaQo1g4tzfvvIrkBraokhlNEN9TkyWeHAjcylb0+A/+ALK0Kx+CAEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=iW6iVKZO; arc=none smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="iW6iVKZO"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F1F783E2839;
	Mon, 01 Jun 2026 14:15:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-109-200-72.trex-nlb.outbound.svc.cluster.local [100.109.200.72])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1404C3E2CEB;
	Mon, 01 Jun 2026 14:15:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Share: 177bc0fb0c50a253_1780323318804_3883097158
X-MC-Loop-Signature: 1780323318804:3578575247
X-MC-Ingress-Time: 1780323318804
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.200.72 (trex/7.1.5);
	Mon, 01 Jun 2026 14:15:18 +0000
Received: from offworld (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4gTbZq1pnnz103R;
	Mon,  1 Jun 2026 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780323317;
	bh=xpMCNuqlgji1uar7Zqv7L29JC9fKxnZYtZkLo8j9Yrs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=iW6iVKZO8X4ln3tKNwWZWyL4vj1tqicAfRJi3eg1RWYuDA8J6eSV+6dsxZHE4LZVu
	 /LQJBmQUa0p+0XSxJ1Ar3f2R+cAjD2ChfW23RQdO+VC6bVXTTP6w3ejJL/SskWxpPL
	 iqgyBnhE/qBPVYKngkSCriXf1+lBXrM5mvUj45mzsJ/0I/uDcAdGajPddYjhdiEVmp
	 N85dCzCPFCaybbOyX3s74FxL/xG+wjICEzKUFHvSpoEawJlpLKRlWc1oGlU5d3/rY0
	 ycGApH6JIC8oBMOGisgpyRLRWFJZkneEZVvd1u6yP/OJ2M5ttiV6g/3y352nyekG67
	 QYFFQMlg4Ay4A==
Date: Mon, 1 Jun 2026 07:15:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, dave.jiang@intel.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, ira.weiny@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/5] cxl: Support Back-Invalidate
Message-ID: <20260601141510.oiz6yy27mjonncib@offworld>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <6a0bc26656f_128d711001f@djbw-dev.notmuch>
 <20260519124133.1f2bd813@jic23-huawei>
 <6a0ce81082439_16dbc610018@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6a0ce81082439_16dbc610018@djbw-dev.notmuch>
User-Agent: NeoMutt/20220429

On Tue, 19 May 2026, Dan Williams (nvidia) wrote:

>The BI bit in the CFMWS, unlike volatile and PMEM restrictions, has
>additional references by bit0 and bit1:
>
>Bit[0]: ...(HDM-D if bit[5]=0; HDM-DB if bit[5]=1).
>Bit[1]: ...If an HDM decoder that is mapped to this windows has the BI
>        bit set (bit[5]=1), it will result in undefined behavior.
>
>The Bit[0] wording does not appear to leave room for optionality.
>
>The Bit[1] wording needs fixing, but to my eyes says "host-only ==
>host-only, do not enable BI operation in any decoder that maps this
>window and expect it to work".

So for the qemu support, the Window restrictions will need to be updated.
It used to be 0xF (bit0+bit1 enabled), which is wrong, and then bit5 was
enabled when BI support was added.

I think we should just set it to host-only coherent (bit1), and then
just rely on restrictions= parameter for testing device-coherent. Otherwise,
as is, the kernel will always try to go for BI and fail when not passing
hdm-db option to the device. The kernel should also probably complain if
it sees a Window with both kinds of coherency restrictions.

Thanks,
Davidlohr

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 11a455b28ab8..a2595633ff0c 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
      if (object->has_restrictions) {
          fw->restrictions = object->restrictions;
      } else {
-        fw->restrictions = 0x2f; /* No restrictions */
+        fw->restrictions = 0xe; /* host-only coherent, volatile, pmem */
      }
  
      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));

