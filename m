Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9B481A9A;
	Fri, 15 May 2026 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853238; cv=none; b=hDyGeowze4kIOfFY+Vn9Yhhl8YkBmIOXMDOCOWJMm7wopRk6WqOJ3OvYravS6w1cKr1WfvPchchJzMtawEcBkua5hpUX+e7TQfFGZRWAI8FuMb/0z9Y4pHF3YaPPTu7SzE/J5UZhozF8ngWrDVUboOANlbSz3j293YL27y+xjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853238; c=relaxed/simple;
	bh=eLrwuwge19OeUvKYvQMSZkWEeWCl6qdHqKFPKvIHECE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3j3i21B9y9nw8NoxwNYHIhmM63bjx9Lw2c0NWBHhBhpVH08BDnfVKfIbtyfOg5ibQIFsIXNIVIUojlIFC+RaYez4ffWEJX9hSW91V0WpR2WZZv4Luf+6DDDMZ7wTTj4FWk/Mww4nzTHGebYUNTJs20JRKx7j33J1gTg1fijTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rWE8t0XP; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rWE8t0XP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778853226; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2nIDZb5iPeMI/Inl10h9OU4YKStjWSoaAyN90viE+ac=;
	b=rWE8t0XPXruXoMn9w466uGh9OsvttJuCDqZNfoG3odsO01uYyiInP+/SOeiVowrsPIk1jNHTXTelDkG8kYIK9X3rbu7fMG33K0YYVUSDSYNdchzVqyL8SCxQaynm3BnQZURiWJoYySaxKYF8C9YsSWyWXzedLMFoffpP4h2i2UA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2zhYjI_1778853220;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X2zhYjI_1778853220 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 May 2026 21:53:45 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave.jiang@intel.com
Cc: alison.schofield@intel.com,
	cp0613@linux.alibaba.com,
	dave@stgolabs.net,
	djbw@kernel.org,
	guoren@kernel.org,
	ira.weiny@intel.com,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Fri, 15 May 2026 21:53:40 +0800
Message-ID: <20260515135340.18692-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f7f2e06e-e8a5-46b2-8516-235be474251e@intel.com>
References: <f7f2e06e-e8a5-46b2-8516-235be474251e@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 10:10:50 -0700, Dave Jiang wrote:

> > On some platforms (e.g., RISC-V and ARM64) that use the generic
> > pci_acpi_scan_root() implementation, cxl_acpi_probe may run before
> > acpi_pci_root driver has bound to ACPI0016 (CXL host bridge) devices.
> > In this case, acpi_pci_find_root() returns NULL, causing
> > to_cxl_host_bridge() to skip the device silently. This results in
> > incomplete CXL port enumeration on first boot.
> > 
> > Fix this by detecting the case where an ACPI0016 device exists but its
> > PCI root bridge is not yet ready, and returning -EPROBE_DEFER to trigger
> > a deferred probe retry.
> > 
> > Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> > ---
> >  drivers/cxl/acpi.c | 26 ++++++++++++++++++++++++--
> >  1 file changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 127537628817..9952d0cff903 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -631,8 +631,21 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >   struct acpi_pci_root *pci_root;
> >   struct cxl_port *root_port = arg;
> >   struct device *host = root_port->dev.parent;
> > - struct acpi_device *hb = to_cxl_host_bridge(host, match);
> > + struct acpi_device *adev = to_acpi_device(match);
> > + struct acpi_device *hb;
> >  
> > + /*
> > +  * If this is an ACPI0016 device but acpi_pci_find_root() hasn't
> > +  * found the PCI root yet (driver not probed), defer the probe
> > +  * to allow acpi_pci_root to bind first.
> > +  */
> > + if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
> > +     !acpi_pci_find_root(adev->handle)) {
> > +  dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
> > +  return -EPROBE_DEFER;
> > + }
> > +
> > + hb = to_cxl_host_bridge(host, match);
> >   if (!hb)
> >    return 0;
> >  
> > @@ -688,7 +701,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  {
> >   struct cxl_port *root_port = arg;
> >   struct device *host = root_port->dev.parent;
> > - struct acpi_device *hb = to_cxl_host_bridge(host, match);
> > + struct acpi_device *adev = to_acpi_device(match);
> > + struct acpi_device *hb;
> >   struct acpi_pci_root *pci_root;
> >   struct cxl_dport *dport;
> >   struct cxl_port *port;
> > @@ -697,6 +711,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >   resource_size_t component_reg_phys;
> >   int rc;
> >  
> > + /* Same deferral check as in add_host_bridge_dport() */
> > + if (strcmp(acpi_device_hid(adev), "ACPI0016") == 0 &&
> > +     !acpi_pci_find_root(adev->handle)) {
> > +  dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
> > +  return -EPROBE_DEFER;
> > + }
> 
> I don't believe this check in add_host_bridge_uport() is necessary. add_host_bridge_dport() happens first and the check should've been done there. There is no reason to do it again and you'll never reach here if it's not ready. 
> 
> DJ

Hi Dave,

You're right. Since add_host_bridge_dport() is called first and
cxl_acpi_probe() returns early on error, add_host_bridge_uport()
will never be reached if the PCI root is not ready. I'll drop the
duplicate check in v2.

Thanks,
Pei

> > +
> > + hb = to_cxl_host_bridge(host, match);
> >   if (!hb)
> >    return 0;
