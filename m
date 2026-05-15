Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934348124E;
	Fri, 15 May 2026 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778852839; cv=none; b=L45vTE18WlIYqtWeRv2cGy5WI4GtQmoPO1vtsZhtrsaqgQlwqKGxucdmIPVwkRhByEFhBob92GHdk9Hj4D5yK4YuwjER1V8fNkzWtG7/nlhDIyOkw8GuVcrltKT4GWSnzbeuEEd0Q92QiKyy0OD/7GrkH/8oQ/sB3k+hLh18ATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778852839; c=relaxed/simple;
	bh=Nlv+PoDsMlIopTuZVNqeTgK6W0vHJBOSQuLTZ6U8F9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wcx9TaB+TtSz1ANEPbzHftYfLVlZt5a1PvHFTREttaSlWQkWalucIlq5woKgfn3DpKFDHOhfdZOY0WaBHzfkHyOO8L/KbLJgWESOGX+rn3QcNxSfo5sx+eCz03yrCy3OfGqrjeL28NC9xDyQv4Dq6Y9fgFcWsJpnAByrL3M8ktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xX4uT5WS; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xX4uT5WS"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778852821; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=Iq9KDz/3bmw3mOdvx+/tUZwlKbUlUhX2ku9llRA98Fg=;
	b=xX4uT5WSV/38DhhbXfHsqV22FbZozssihvIm8kcs1XO3lCqpQKzgALxOe9m07NOlP8OjYBHmqhrsbFjaTrNAWTn5eLgBm5e3P9AVAt9EJifLgJYwN95ZT8Khf2m0AKBS6wk1DcVoVvLcOvz/y0qPw0iM8T+8nwns2949j/5IwKQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X2zhX7r_1778852813;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X2zhX7r_1778852813 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 May 2026 21:47:00 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: icheng@nvidia.com
Cc: alison.schofield@intel.com,
	cp0613@linux.alibaba.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	djbw@kernel.org,
	guoren@kernel.org,
	ira.weiny@intel.com,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vishal.l.verma@intel.com
Subject: Re: [PATCH] cxl/acpi: Defer probe when ACPI0016 PCI root bridge is not ready
Date: Fri, 15 May 2026 21:46:49 +0800
Message-ID: <20260515134652.15486-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <agV2e28XjW7yOUwH@MWDK4CY14F>
References: <agV2e28XjW7yOUwH@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

On Thu, 14 May 2026 15:31:11 +0800, Richard Cheng wrote:

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
> 
> Hi Chen Pei,
> 
> Thanks for the patch.
> I have a few questions and suggestions regarding to your changes.
> 
> First of all I would like in which scenario did you encounter the bug?
> Any specific CONFIG options and the devices ? what's the error log ?
> 
> It would be nice if you can attach it for us.

Hi Richard,

Thanks for the review.

I'm currently working on bringing up CXL support on the RISC-V QEMU
virt platform with ACPI (EDK2 UEFI firmware). This is still in the
early debugging/enabling stage.

During testing, I found that cxl_acpi (ACPI0017) probes before
acpi_pci_root has bound to the ACPI0016 (CXL host bridge) device.
RISC-V uses the generic pci_acpi_scan_root() implementation, where
the probe ordering of acpi_pci_root relative to cxl_acpi is not
guaranteed.

On x86, acpi_pci_root uses subsys_initcall and binds very early,
so this race does not manifest there.

This is a silent failure (no explicit error log), which makes it
particularly hard to diagnose. When cxl_acpi probes before
acpi_pci_root has bound the ACPI0016 device:
1. acpi_pci_find_root() returns NULL in to_cxl_host_bridge()
2. to_cxl_host_bridge() returns NULL
2. Both add_host_bridge_dport() and add_host_bridge_uport() return 0
   (not an error), silently skipping the host bridge
3. cxl_acpi_probe() returns success, but the CXL port topology is
   incomplete — no dports or uports are registered

The observable result after boot:
    # memdev is visible but decoder hierarchy is missing
    $ cxl list -M
    [
      {
        "memdev":"mem0",
        ...
      }
    ]

    # No decoders or ports registered for the host bridge
    $ cxl list -BDP
    []

    # Workaround: manually unbind/bind triggers re-probe after
    # acpi_pci_root is ready, and CXL topology enumerates correctly
    $ echo ACPI0017:00 > /sys/bus/platform/drivers/cxl_acpi/unbind
    $ echo ACPI0017:00 > /sys/bus/platform/drivers/cxl_acpi/bind

    # After re-probe, full topology is available and CXL memory
    # can be enabled/onlined successfully
    $ cxl enable-memdev mem0
    $ cxl create-region -m -t ram -d decoder0.0 -w 1 mem0 -s 4G
    $ daxctl online-memory dax0.0

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
> 
> What about strncpy() here since we already know we're comparing against "ACPI0016" ?
> At the same time, why not just use "acpi_dev_hid_match()" ? it's widely used across
> numerous files.

Good point, thanks. I will switch to the acpi_dev_hid_match() in v2.

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
> > +
> > + hb = to_cxl_host_bridge(host, match);
> >   if (!hb)
> >    return 0;
> >  
> > -- 
> > 2.50.1
> > 
> > 
> 
> These 2 checks are basically the same, can we put it in a static inline helper or
> a macro if possible? something like the following might be better
> 
> ```
> static int cxl_acpi_defer_host_bridge(struct device *host,
          > struct acpi_device *adev)
> {
 > if (acpi_dev_hid_match(adev, "ACPI0016") &&
     > !acpi_pci_find_root(adev->handle)) {
  > dev_dbg(host, "deferring probe, ACPI0016 PCI root not ready\n");
  > return -EPROBE_DEFER;
 > }
 > return 0;
> }
> ```
> and use it in your code like
> 
> ```
> int rc = cxl_acpi_defer_host_bridge(host, adev);
> if (rc)
 > return rc;
> ```

Agreed, will extract it into a helper in v2.

> Last but not least, have you run the kselftests of CXL ? some mock bridges
> are platform devices, not ACPI devices, you are using "to_acpi_device(match)", this
> is not a safe runtime check when "match" is a platform_device, the code will read the memory
> layout wrongly.

Good catch, I haven't run the CXL kselftests. You're right that the
mock bridges are platform devices and unconditionally calling
to_acpi_device(match) would be unsafe there.

I'll fix this in v2 by adding a dev_is_platform() guard in the
helper, so it only applies to real ACPI devices. I'll also run
the CXL kselftests to validate before sending v2.

Thanks,
Pei
