Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F513957E
	for <linux-cxl@vger.kernel.org>; Fri,  3 May 2024 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713185; cv=none; b=AeojUpUhuq86K/X8lLYhmx3MRL3wcHd2AKyRcZa8BFziMDJCDePRaQlAgnGzzAYgl52NtQ5X5UaJG5EvRVB7nDg/yc52lyqiOGStbSKIIIyGsYdP6LCrFsbLexXe319ffaygP/wPUYGi1j1M8qt9A/kIV9e3bx30DCpLfwG6HxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713185; c=relaxed/simple;
	bh=RJfCpz3IgkmkNHRNxdmGWf3bBlQxiovF4wODXhNM/BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz3k8qCJM8rWV3sneej5bjVZcvUe916hWWtZjoFvET9VcGDP/yBgeLKVVHJiyYEqohoGmVK6ZAaDpEoE/vPv+vaTRL89LASiB7sUoLb087BeRRdZfKbY2VX2mozdYvMBa6hwMxf2p0WFOpzikguCSGcWpawA5DMr7ivQa5jV53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo7PRYPn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo7PRYPn"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so5093003a34.2
        for <linux-cxl@vger.kernel.org>; Thu, 02 May 2024 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714713183; x=1715317983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1exDMYdKKOv6j+nKRmmPtBgRUJm0rdQUtcFwal8QNo=;
        b=jo7PRYPnM+/e8w7KDG+bVFGuDDCfflgHptoHfwzse1CXMMq/dMW4YG4oViJ/FAGB0A
         FX1i0s2AIhZwfxQhiLJdcCoeZhV1QX/mPhQ4H+mMyiKeLM1kHJvI09LtLm1+hMwB/HgC
         3jHbAWJ1vEVaRNckZrBgapa2XtJAOpQf9Z96FucLT821wlOZWMSLVsy7+B1wKwjahFq8
         IrLd9OfMhej5GdfBLUPwbVOK7ejzm50v60LavNDxq5e+NN6ZwStv3/DIWBNKw635MeSf
         +8L/ys7eYwwsHKyBewaKCbH2VDO80Xwujw88U0YRt9uHF6C9Z6N8NWDozWTm3EuSA+bK
         qSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714713183; x=1715317983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1exDMYdKKOv6j+nKRmmPtBgRUJm0rdQUtcFwal8QNo=;
        b=tWgWPd9eMT62/PYx5AlViXrlc3wh+UY9+zf5TZBSMwjuwrAQjF5BHfX8F1CO9k3ppL
         V6uxTqjgm4UdUqcGZRItgSyyTskTcylrYb/z1TdNMcLqhHxI0rH3HEfS4u496sRfJvSO
         PbHJb+zr4SP7r11vjiZysWsCTLEdf1hw6e0YDDtbcnVaJnCKondUhzUyseUZVliqqUrP
         oGBbL8dAFTafBP1GEPEiwGl3DPgCAqqD/T+FNac+JZ9l1SETrUvFwiwUvsSiNy7ggVcO
         JP+JqIZxPXUurs0KhQXo0r+roTRJbzU8rcEPy/EH7SSPD/yf5YIH84yOIsllvMGXcQCl
         3Log==
X-Gm-Message-State: AOJu0YxuXBNRC13CSn3vtKmRHnrrhb94cwYvrfslk4ni4vBllL8kPzNh
	h0/PLwAm2JvUPDpRT/nErKtuYzZT48KXsbuGWUKVdh56xxLz41rD
X-Google-Smtp-Source: AGHT+IG40cc3968vT8apuchfQYN85QKlZDmZLem1Ga3AKGRvARsMimfgz+AMR+H4hxMgc7mgApfxYQ==
X-Received: by 2002:a05:6358:88a:b0:186:68fb:5061 with SMTP id m10-20020a056358088a00b0018668fb5061mr1689521rwj.24.1714713182642;
        Thu, 02 May 2024 22:13:02 -0700 (PDT)
Received: from hyeongtakPC.. ([147.46.174.104])
        by smtp.googlemail.com with ESMTPSA id l191-20020a6391c8000000b0061aa394533csm1823147pge.16.2024.05.02.22.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 22:13:02 -0700 (PDT)
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: linux-cxl@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	ave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [RFC PATCH 0/4] cxl: introduce CXL Virtualization module
Date: Fri,  3 May 2024 14:12:49 +0900
Message-Id: <20240503051249.1644083-1-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231228060510.1178981-1-dongsheng.yang@easystack.cn>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Dongsheng,

Thank you for sharing this work!  I might be a little late but it would be
helpful if you can answer a few questions below.

On Thu, 28 Dec 2023 06:05:06 +0000 Dongsheng Yang <dongsheng.yang@easystack.cn> wrote:
> Hi all:
> 	This patchset introduce cxlv module to allow user to
> create virtual cxl device. it's based linux6.7-rc5, you can
> get the code from https://github.com/DataTravelGuide/linux
> 
> 	As the real CXL device is not widely available now, we need
> some virtual cxl device to do uplayer software developing or
> testing. Qemu is good for functional testing, but not good
> for some performance testing.
> 
> 	The new CXLV module allow user to use the reserved RAM[1], to
> create virtual cxl device. When the cxlv module load, it will
> create a directory named as "cxl_virt" under /sys/devices/virtual:
> 
> 	"/sys/devices/virtual/cxl_virt/"
> 
> that's the top level device for all cxlv devices.
> At the same time, cxlv module will create a debugfs directory:
> 
> /sys/kernel/debug/cxl/cxlv
> ├── create
> └── remove
> 
> the create and remove debugfs file is the cxlv entry to create or remove
> a cxlv device.
> 
> 	Each cxlv device have its owned virtual pci related bridge and bus, cxlv
> will create a new root_port for the new cxlv device, setup cxl ports for
> dport and nvdimm-bridge. After that, we will add the virtual pci device,
> that will go into the cxl_pci_probe to setup new memdev.
> 
> 	Then we can see the cxl device with cxl list and use it as a real cxl
> device.
> 
>  $ echo "memstart=$((8*1024*1024*1024)),cxltype=3,pmem=1,memsize=$((2*1024*1024*1024))" > /sys/kernel/debug/cxl/cxlv/create

I tried following your usage (w/ "memmap=8G$8G") but it does not seem to work
well. After creation I got logs like below:

  [   35.484764] PCI host bridge to bus 0010:00
  [   35.485015] pci_bus 0010:00: root bus resource [io  0x0000-0xffff]
  [   35.485446] pci_bus 0010:00: root bus resource [mem 0x00000000-0x7fffffffff]
  [   35.485817] pci_bus 0010:00: root bus resource [bus 00-ff]
  [   35.486126] pci 0010:00:00.0: [7c73:9a6c] type 01 class 0x060400
  [   35.486436] pci 0010:00:00.0: reg 0x10: [mem 0x200100000-0x2001fffff 64bit pref]
  [   35.486875] pci 0010:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
  [   35.487300] pci 0010:01:00.0: [7c73:9a6c] type 00 class 0x050210
  [   35.487745] pci 0010:01:00.0: reg 0x10: [mem 0x200000000-0x2001fffff 64bit pref]
  [   35.488171] pci 0010:00:00.0: PCI bridge to [bus 01-ff]
  [   35.488438] pci 0010:00:00.0:   bridge window [io  0x0000-0x0fff]
  [   35.488756] pci 0010:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
  [   35.489101] pci 0010:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
  [   35.489462] pci_bus 0010:01: busn_res: [bus 01-ff] end is updated to 01
  [   35.511966] pcieport 0010:00:00.0: enabling device (0000 -> 0003)
  [   35.512403] pci 0010:00:00.0: enabling device (0000 -> 0003)
  [   35.512738] cxl_pci 0010:01:00.0: enabling device (0000 -> 0002)
  [   35.517755] cxl_virt cxlv0: unsupported cmd: 0x301
  [   35.542026] cxl_virt cxlv0: unsupported cmd: 0x4500
  [   35.543738] cxl_virt cxlv0: unsupported cmd: 0x4500

Is it normal to get "unsupported cmd" here?

>  $ cxl list
> [
>   {
>     "memdev":"mem0",
>     "pmem_size":1879048192,
>     "serial":0,
>     "numa_node":0,
>     "host":"0010:01:00.0"
>   }
> ]

I got the exact same result against `cxl list`.

>  $ cxl create-region -m mem0 -d decoder0.0 -t pmem
> {
>   "region":"region0",
>   "resource":"0x210000000",
>   "size":"1792.00 MiB (1879.05 MB)",
>   "type":"pmem",
>   "interleave_ways":1,
>   "interleave_granularity":256,
>   "decode_state":"commit",
>   "mappings":[
>     {
>       "position":0,
>       "memdev":"mem0",
>       "decoder":"decoder2.0"
>     }
>   ]
> }
> cxl region: cmd_create_region: created 1 region

Instead of successful region creation, what I could find was

  $ cxl create-region -m mem0 -d decoder0.0 -t pmem
  cxl region: create_region: region0: failed to commit decode: No such device or address
  cxl region: cmd_create_region: created 0 regions

How can I follow your usage in the letter?

...snip...

Kind regards,
Hyeongtak
