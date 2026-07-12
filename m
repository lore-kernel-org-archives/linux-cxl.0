Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACF1A6807
	for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862366; cv=none; b=IIZS3+s/5WnA2k/gHMNVjJJpXOCmjk+6YJk49n51uSCDSj+gDhyVa9AauxXDDQExKfL0V1M5aR489GJT2I3tTR9SWzh1ACrTfVlsRHzLXU0PqykMutvTkk7aH8JjyJKNSNwH/JowPAu+AZUZ1O/xuOxDieKDJgNlpPZMjLioliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862366; c=relaxed/simple;
	bh=GA2n3X3YYxv/xqLwggfAp+Psl9pqkPA1TJ/rGYjWIzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4xznrqg9o6TL33oUGGFoqaGlq8fVOZ3vh/DrtcwvXbfKV0ZpEDOqgiHeaGZUYsBeCcxsaDvubPvuO4ptKISgCucHwqS8XojaEE9D/6WRLaoPOoPUYFM0Rb9uwY8nxIZfplxxvnquYIeh8ncrdIJHLfdhhZxXVRGT9b+btDukHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kolM/bBU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kolM/bBU"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e4fd65b2bso121330385a.0
        for <linux-cxl@vger.kernel.org>; Sun, 12 Jul 2026 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783862364; x=1784467164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=39bk0iOpnnnuS6FEq1W2d71iiM95MbzJdYJU5SoGT3c=;
        b=kolM/bBUACGSqhFuyez3cvVLN5p6Lx2CDOAkO6RcWxyxarwmE/PoVGvfqP7kMEFBfg
         UExX0g6WcFSu743R55JHzbUR/5qC4mCVK9F00WnuAwSrvF1Kt6wI9ffK4EFEYdP5rIy2
         FBHn/YREwkAxFMF4vwGnBUJfYo+O7xPkJFAtWsToF8VRCyg1MaF2f7W96NYy/QU8dyKD
         PaUwgwjwBGEFNbumJ2gA3MDr09/RBzoQzobgSjw4R30PMzdVWhOSbosa+HB4WId57JxI
         5ZHWqxYS6Y9KQYI84APA9H8qrh3yJrs8Lfbjv3XncAy4c6it9Q+N4ZzcKycMKYWnl0ch
         h7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783862364; x=1784467164;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=39bk0iOpnnnuS6FEq1W2d71iiM95MbzJdYJU5SoGT3c=;
        b=m52rejllawZcTv+PatZ/azOnoWml8bDuER5+vkfy8OViP8Nni0F2tCHJqgZ/H2Whqg
         cpVri9BsAfaH468UvuiDwl8GMXlCuwasHDqe/NUwE1rvYNAdfcRA7/K9t5xph1xutA08
         0FQvIqfqMdWayrEAXw/D4d25LCH6hzsoPZwM4+LfTGD4mFhPhP09epKKOrreU/4+oNdD
         nwSGgHwd5FEBvENdZC5S1x4oxwJvF8PGDb68zWMOcXrpYq/qz1L+kvRE203ITQ5t+tFn
         JIvK6igbA1VnrOLZZD4RRtzOhZngZyI4nwgiKSsVkLOPwPhaJL9/LIYyrf8qN2eVfmsQ
         w6Ww==
X-Forwarded-Encrypted: i=1; AHgh+RrhHrtnbM/BnUfP6khW0uzu61QEBbkgxJXpljq+8H2uiNmuT2fNAe1czhtGrC4z5zyuSL4kFbHqBfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXjP4unS5ZyvtGHhJZTXdA4kUtYGICE9LvSIuI4neazMhdRfr
	Aq4MQ27qdVAKrbuUMU6ChsVQq7Q+5BH0rfHw+HtNNM/om25++fZLJUbIcCDIqPsPUmcpVHNgO8V
	ZJltd
X-Gm-Gg: AfdE7cnLV6xo+3Ke59sm72fLJGHW47QNKKW+3tjSVbywXv6M9Ax8clJZFU/Kszbwbfz
	KFq2FRVS4ndIPjkOgAsami0YXCkFnCvo69x4PI5OKCEbb2Ph10BVtUd27HaBlqQ00VW127YqWlS
	RmNshkU0+aBbULrXk9DGGUJ6zJZBnZLATKCBgbhZfnxnnhGRyCumM5iDKYRNpoovxgSL/oFUm9F
	9014N9a0PScGh2q9SzHAAQWHcvSj8/C142xgp29Vi9GUC4sNC14zcNsSIiszu1son9YilCVd7NE
	cGlKuoBsYug5lZutG/TXFg0i1dw3KGLIHAjjq5Vpx3UGtMUq6nr2nkIj5V8HHZumdGzDHYUNSVJ
	SA/r/bRDHEw0L8p01Y5HwPh7KFHVkRpFUJAKGJKgUMuEnuBDUOpS6MkuvQVyoXl/XaD1Gcvfkxn
	bn660nt926pHkoYPOVry3PiDM1dcer4sTcOhofsXclFITLfP0skwuZ2isdeuINdOAnZ+cR
X-Received: by 2002:a05:620a:28cb:b0:92e:94a7:16e8 with SMTP id af79cd13be357-92ef2b354f5mr605721685a.15.1783862364130;
        Sun, 12 Jul 2026 06:19:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b38dsm900591885a.10.2026.07.12.06.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 06:19:23 -0700 (PDT)
Date: Sun, 12 Jul 2026 09:19:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com
Subject: Re: [PATCH v6 07/10] dax: plumb hotplug online_type through dax
Message-ID: <alOUVvJCSQDO6yNn@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-8-gourry@gourry.net>
 <6a5016bf71df4_3b7ee5100b3@djbw-dev.notmuch>
 <alAb7Q_Ku5dVRKZ7@gourry-fedora-PF4VCD3F>
 <alBLJoM86ujz5Fg1@gourry-fedora-PF4VCD3F>
 <6a51920acece6_35cf3310061@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1q15GSERqnHPArbK"
Content-Disposition: inline
In-Reply-To: <6a51920acece6_35cf3310061@djbw-dev.notmuch>


--1q15GSERqnHPArbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 10, 2026 at 05:44:58PM -0700, Dan Williams (nvidia) wrote:
> Gregory Price wrote:
> > On Thu, Jul 09, 2026 at 06:08:45PM -0400, Gregory Price wrote:
> > > On Thu, Jul 09, 2026 at 02:46:39PM -0700, Dan Williams (nvidia) wrote:
> > > 
> > > This was more a matter of having the DEFAULT set consistently across
> > > the dax driver variant probe() functions to make the behavior explicit.
> > > I didn't want an un-set value bug to creep in here somehow.
> > > 
> > > Happy to drop them if you think that's unneeded.
> > > 
> > 
> > Ah
> > 
> > Not setting the value in each of those places is equivalent to setting
> > MMOP_OFFLINE (0), so better to just set DEFAULT regardless.
> > 
> > So unless you have strong feelings i will keep them as-is.
> 
> Right, the mild feelings are only coming from the changelog mismatch
> which says "Oh no, device-dax drivers can not specify their online type
> besides the default" and all this series does is keep the status quo.
> 
> That can be had by just having unconditional:
> 
>      online_type = mhp_get_default_online_type();
> 
> ...in dev_dax_kmem_probe() and get rid of dev_dax->online_type until the
> first user arrives. If you are respinning the series and that patch
> drops, yay. If not, oh well.

if you prefer, i can add the CXL build option to this series instead of
the follow up (attached).  The code is fully contained in DAX anyway,
and I have it sitting off in another branch anyway.

I suppose with this, we can terminate the entire series and the first
user that grows an opinion can add the following:

cxl/cxl.h:
    struct cxl_dax_region *cxlr_dax {
    +   int online_type
    };

dax/cxl.c:
   data.online_type = (cxlr_dax.online_type == DAX_ONLINE_DEFAULT) ?
                      cxl_dax_online_type() : cxlr_dax.online_type;

~Gregory

--1q15GSERqnHPArbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-dax-cxl-add-build-time-CXL-RAM-region-auto-online-po.patch

From b2cb5c4f5f03dd698df97ae3db2c0207db4acd83 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Thu, 9 Jul 2026 19:31:28 -0700
Subject: [PATCH] dax/cxl: add build-time CXL RAM region auto-online policy

CXL devices using kmem follow the single global auto-online policy.

On systems with multiple drivers using memory hotplug, this makes
management more complex - a single special kmem device forces all
kmem devices to be managed manually in userland.

Add a build-time option to select CXL device online policy.

  - System default   -> DAX_ONLINE_DEFAULT (default)
  - Online           -> MMOP_ONLINE
  - Online (movable) -> MMOP_ONLINE_MOVABLE
  - Online (kernel)  -> MMOP_ONLINE_KERNEL
  - Unplugged        -> DAX_KMEM_UNPLUGGED

Default to system default to retain userland backward compatibility.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/Kconfig | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/dax/cxl.c   | 15 ++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 80aeb0d556bd7..52450225dbb11 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -212,6 +212,47 @@ config CXL_REGION
 
 	  If unsure say 'y'
 
+choice
+	prompt "CXL Memory Hotplug Policy"
+	depends on CXL_REGION
+	default CXL_MEMHP_POLICY_SYSTEM_DEFAULT
+	help
+	  Select the online policy the CXL driver requests when a region is
+	  hotplugged as System RAM.
+
+	  If unsure, select "System default".
+
+config CXL_MEMHP_POLICY_SYSTEM_DEFAULT
+	bool "System default"
+	help
+	  Follow the system-wide memory hotplug policy.
+
+config CXL_MEMHP_POLICY_ONLINE
+	bool "Online"
+	help
+	  Automatically online memory and let the kernel choose the zone.
+
+config CXL_MEMHP_POLICY_ONLINE_MOVABLE
+	bool "Online (movable)"
+	help
+	  Automatically online the memory into ZONE_MOVABLE. Choose this for
+	  memory that may need to be hotremoved later, or if you do not want
+	  unmovable, kernel allocations to land on this memory.
+
+config CXL_MEMHP_POLICY_ONLINE_KERNEL
+	bool "Online (kernel)"
+	help
+	  Automatically online the memory into ZONE_NORMAL. The kernel may
+	  place unmovable allocations on this memory.
+
+config CXL_MEMHP_POLICY_UNPLUGGED
+	bool "Unplugged"
+	help
+	  Create the dax/kmem device but add no memory at bind time.
+	  Choose this if a userland orchestrator will manage the device.
+
+endchoice
+
 config CXL_REGION_INVALIDATION_TEST
 	bool "CXL: Region Cache Management Bypass (TEST)"
 	depends on CXL_REGION
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 1a7ec62122134..15f70d578c22b 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -6,6 +6,19 @@
 #include "../cxl/cxl.h"
 #include "bus.h"
 
+static int cxl_dax_online_type(void)
+{
+	if (IS_ENABLED(CONFIG_CXL_MEMHP_POLICY_UNPLUGGED))
+		return DAX_KMEM_UNPLUGGED;
+	if (IS_ENABLED(CONFIG_CXL_MEMHP_POLICY_ONLINE))
+		return MMOP_ONLINE;
+	if (IS_ENABLED(CONFIG_CXL_MEMHP_POLICY_ONLINE_MOVABLE))
+		return MMOP_ONLINE_MOVABLE;
+	if (IS_ENABLED(CONFIG_CXL_MEMHP_POLICY_ONLINE_KERNEL))
+		return MMOP_ONLINE_KERNEL;
+	return DAX_ONLINE_DEFAULT;
+}
+
 static int cxl_dax_region_probe(struct device *dev)
 {
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
@@ -27,7 +40,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
 		.memmap_on_memory = true,
-		.online_type = DAX_ONLINE_DEFAULT,
+		.online_type = cxl_dax_online_type(),
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
-- 
2.53.0-Meta


--1q15GSERqnHPArbK--
