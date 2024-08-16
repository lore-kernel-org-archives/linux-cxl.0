Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76531BDABA
	for <linux-cxl@vger.kernel.org>; Fri, 16 Aug 2024 18:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833170; cv=none; b=RVT82Bg65+awMicMrVE45AvucHRZTta3u9lyN4hIXT3nXtuEgGUTmnftHut9r3BEEKFszcu0xUggWmcXOwO2AAuZTX/1522H+Mahzc5PKNuRUiO2lN1amWz3ZE3N08Fk5YEVVFQefq9tDE0BsEjMefsgOEnFYod6wJ6iBY7zPow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833170; c=relaxed/simple;
	bh=sqBlDYYe+xJpwACaKDyMfF9NxH+kMPPNUTDDVwfyb0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQhH/YcyoVSlATnDtLQqURmZmTua0xFZgwUnMSoLiLXwQZmDnbA+R5Q3joqe18Vi1yEI5CngH3W244RYTBtMRzp5CZfEA9AyyCCthU6L3rQiILJ36omdDA7sEcQ1UBfaEzHJWGS/AxHud9H/qWNURIpye+P7ZKTVW+GW7xC7SaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Narn3HSk; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Narn3HSk"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf7f4a133aso5291526d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 16 Aug 2024 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1723833167; x=1724437967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25KDEXnm6DLgip12pSEllSf24x/AMgAnP17PmbvYjCY=;
        b=Narn3HSkTEzudoNM8PEyOB0gT2i3UzxQy6JLuGKwdVDm3Kv7V6erE579MFQ4to5qfl
         EHOloPMVoatZKT2kcFu5rFhobFTx/R7wV6fmgoYOzaYcjeglaLUKMTXhEzslTIzK9Sh/
         ol83NwQ+v5KG2S6P8K8IiR5fSrSjnpJbWUUwxEouME0rxXaLf25TAbUgZSVzlv7WYqgR
         j2sYWWVyHNw0SULa2QszPdYSeQxNPMvQGGmmUsNarEwHWf99SoSK1P4R+Z4pGcJPxQNs
         fcdnraBKN/p/qbLphlvPX3NqSv/OxIiR9fDSlscZI3LWHX4w3XH0vDjbXEFAs9HzvwXb
         l/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833167; x=1724437967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25KDEXnm6DLgip12pSEllSf24x/AMgAnP17PmbvYjCY=;
        b=mdXjjozwnfMyI3dWLbknU93WM9SbgqGHvXHGHFh3r4lZScu0rCPEGKVvRbzkSEYfsZ
         MlsowAwb1ZiHoVMLTiamlK0EnDk/6bKfVTgq+plj/U9kIDiwBKhdVsrAthp7mAgDa8Nj
         qQWEsw/b1cy+b1uGpop+6vlqGOny7tZ+P2hm4eDrUxRCnCaP2dFN2o7wc4/QtZO13dak
         WJFJ6G6V+8ExLWpzImkKBoraBEqIcrrlq+TTtr3cKWITvVxfBP/9IU4KFwkJZW5zG2yj
         R9b7kL2k1kRAvZHoxQSVvZ7fPi5OGgMzW/8b1QWGa7zZLU5WImfjojzEfCVlZJBIawoF
         hOdw==
X-Forwarded-Encrypted: i=1; AJvYcCXOcYfykP/crg+eyCT0McWSVED8WSorIK4O5f6ouS+ece50FQS9ppUC45rCmwl67SJ5u8Z/KZGaioI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbR0pK3rPx8ibQ6P7Pu3CmFuhpmyL9V3pmGAXKcR4gG2d10Ev
	JQPnqamswXWT67VmnyC9lT4YrrCqseW7aDZpwrDjBzGYl8P72ZXUatqqRG08mW0=
X-Google-Smtp-Source: AGHT+IFeUXfbFQq1xqErrB83JkB93nde+CNIB9jmJX5I2LdaP+61jOYfRxYWoA1tiPMJ7n7leTuOCQ==
X-Received: by 2002:a05:6214:3384:b0:6bf:6990:4e50 with SMTP id 6a1803df08f44-6bf7ce4233bmr32481546d6.41.1723833166565;
        Fri, 16 Aug 2024 11:32:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef0706sm20313996d6.116.2024.08.16.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:32:46 -0700 (PDT)
Date: Fri, 16 Aug 2024 14:32:41 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Address translation for HDM decoding
Message-ID: <Zr-bSY9UVncTdY_Y@PC2K9PVX.TheFacebook.com>
References: <20240701174754.967954-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701174754.967954-1-rrichter@amd.com>

On Mon, Jul 01, 2024 at 07:47:48PM +0200, Robert Richter wrote:
> Default expectation of Linux is that HPA == SPA, which means that
> hardware addresses in the decoders are the same as the kernel sees
> them. However, there are platforms where this is not the case and an
> address translation between decoder's (HPA) and the system's physical
> addresses (SPA) is needed.
> 
> This series implements address translation for HDM decoding. The
> implementation follows the rule that the representation of hardware
> address ranges in the kernel are all SPA. If decoder registers (HDM
> decoder cap or register range) are not SPA, a base offset must be
> applied. Translation happens when accessing the registers back and
> forth. After a read access an address will be converted to SPA and
> before a write access the programmed address is translated from an
> SPA. The decoder register access can be easily encapsulated by address
> translation and thus there are only a few places where translation is
> needed and the code must be changed. This is implemented in patch #2,
> patch #1 is a prerequisite.
> 
> Address translation is restricted to platforms that need it. As such a
> platform check is needed and a flag is introduced for this (patch #3).
> 
> For address translation the base offset must be determined for the
> memory domain. Depending on the platform there are various options for
> this. The address range in the CEDT's CFWMS entry of the CXL host
> bridge can be used to determine the decoder's base address (patch
> #4). This is enabled for AMD Zen4 platforms (patch #5).
> 

Just testing this out, and I'm seeing an inability to actually map the
memory, though the reason escapes me.

Do you have the expected workflow of this down?

For example this fails:

echo ram > /sys/bus/cxl/devices/decoder2.0/mode
echo 0x40000000 > /sys/bus/cxl/devices/decoder2.0/dpa_size
echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
echo 4096 > /sys/bus/cxl/devices/region0/interleave_granularity
echo 1 > /sys/bus/cxl/devices/region0/interleave_ways
echo 0x40000000 > /sys/bus/cxl/devices/region0/size
echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
^^^^ at this point: -bash: echo: write error: Invalid argument

echo 1 > /sys/bus/cxl/devices/region0/commit

and while the cxl driver sees the correct topology, the current version
of cxl-cli reports the memdevs as "anonymous" and reports a failure to
lookup the targets for a region

without adding too much bulk to the email

[~/ndctl]# ./build/cxl/cxl list -vvvvv
libcxl: cxl_mappings_init: region0 target0:  lookup failure
[
  {
    "anon memdevs":[
      {
        "memdev":"mem0",
        "ram_size":137438953472,
...
      {
        "memdev":"mem1",
        "ram_size":137438953472,
...
  {
    "buses":[
      {
...
        "decoders:root0":[
          {
            "decoder":"decoder0.0",
            "resource":825975898112,
            "size":260382392320,
            "interleave_ways":1,
            "max_available_extent":260382392320,
            "volatile_capable":true,
            "qos_class":1,
            "nr_targets":1,
            "targets":[
              {
                "target":"pci0000:00",
                "alias":"ACPI0016:01",
                "position":0,
                "id":0
              }
            ],
            "regions:decoder0.0":[
              {
                "region":"region0",
                "resource":825975898112,
                "size":260382392320,
                "type":"ram",
                "interleave_ways":1,
                "interleave_granularity":256,
                "decode_state":"reset",
                "state":"disabled",
                "mappings":[
                ]
              }
...

Do you have a sense of what might generate this behavior?

~Gregory

> Changelog:
> 
> v2:
>  * Fixed build error for other archs [kbot]
> 
> 
> Robert Richter (5):
>   cxl/hdm: Moving HDM specific code to core/hdm.c.
>   cxl/hdm: Implement address translation for HDM decoding
>   cxl/acpi: Add platform flag for HPA address translation
>   cxl/hdm: Setup HPA base for address translation using the HPA window
>     in CFMWS
>   cxl/acpi: Enable address translation for Zen4 platforms
> 
>  drivers/cxl/acpi.c      |  16 +++
>  drivers/cxl/core/core.h |   2 +
>  drivers/cxl/core/hdm.c  | 245 ++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/pci.c  | 119 +------------------
>  drivers/cxl/cxl.h       |   2 +
>  drivers/cxl/cxlmem.h    |   4 +
>  drivers/cxl/cxlpci.h    |   3 -
>  7 files changed, 262 insertions(+), 129 deletions(-)
> 
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> -- 
> 2.39.2
> 
