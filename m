Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3B35944
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979900; cv=none; b=mKVJJMRp93gxvjTvvMSyAKVs6dyxSzK8ruaw1xZgk1SS6un4w3dPuTuj1DqAcTvmLJcrF00OPoRC/143SNTCKAaDdSJ1wa7qy33++U7UvcXM4TbbXCf/z8sLGjtJXUxM1FjQC1JTOiKc8fNrc80ePBF7PLwEzU3x75uYDYWYQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979900; c=relaxed/simple;
	bh=4R8YZc+kDXwEEojtfwbWXx6McjiUNV7Mma88kgdyREE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff16jG4QgutYz6tgkmuUN9LjbhC04AxCdf5kjaK3xBKLUOZXK+T5KYACFS9BF5sSYluw9FzlN3KWr9rkXXvhMVGHSDwryB8L66V6YBg2nSPETZPLQh/1qLY89TWhtxb6Q0bbj399vgsWTwULIKMa5y0zyFLNJR9z146VXKT5rMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J41WC6iM; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J41WC6iM"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7be3f230436so21702185a.3
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jan 2025 14:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1736979897; x=1737584697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+GJf6iotEBRTZAkzi7WhAm5tsyk1yxN439yNtmncUaQ=;
        b=J41WC6iMlLDgJHSL92eVShvMpcAY2rm4B4gvVGdJIDfmHZlgQZXkUxXyZw2uEmqN37
         TbRfKYp9714yHs0f0zXqqNKhOwiF8x/hPb2Pq2705iQ1u9fEwF7GeNdAEoPuUNWoJfdr
         9U+jS+4L0OyFaTP8tze7T+2vmumuTAi6b2gzOkqqbF/pDpgpi1E/4qPbA7RIjqKyrlG0
         m22ReXadq3I4hLnwmP91DFop+WDQI5/RJuiJ8BP4hrcqAc0XdD3fHp4k1T5OD8cU7Cno
         MNRgq/B0/56UsTehq9IsRgzilfKkRCIGRTJ1Qae3err0gR/LU+o9YffgA/l+310F5QNa
         1xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736979897; x=1737584697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GJf6iotEBRTZAkzi7WhAm5tsyk1yxN439yNtmncUaQ=;
        b=uSVsYENvFuWWj5Zgo0NIkVKRQInrf8uDaAzCFAcOQKqsWJxwgFoL3e7jF5k1lOHgfF
         EwyKgq1LkpcHVCXGdSVibgQMG9gHrah+AVJwtzwoNOaOehTSFaYXQed6Ptyv9Rr6TO1L
         GzRNLF51wpjMUE4eBPOBtwvJPfM3XV6ju0ZWLMuh/ObI1MIfA+phbIor7MhTKhIgsys9
         6pJVE6cEVttR8l/v6HzTWlByXrlY7OW7GGNx2zAugCyq2vQO5hqaIqTqSXge5ssdMe5h
         LTzXD24dPcLcKLjQSnJReHIHRgVx9vGBrgiYxsOKqe94tcwcurhDGNJVZhA8Sg2INUAs
         Y5yw==
X-Forwarded-Encrypted: i=1; AJvYcCUcZwzq6Z0C5hCHCtSmWCHxKuxtNeiTCRUPdy2Al6QT0GYTCQKWZzTJS6Oyfl40Ylz1aGzeTdqxxeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvblWtSE99upHuJkTHaJqg6gI4UJE64hQb3qA7qDD0N2KlfLh
	ATaxrHaKqVB13Rw4VEY2jnTlP9iaOYWjuxWDSjMo2bCZ3csUcVLbJ52oPI268sU=
X-Gm-Gg: ASbGncvPc1sDVPCJ34AApMgDJhOeU8QzaYw6q9O4LeMLWBRB63xb11Xwk8M/y6KgJI4
	+smQlYQ0d1EFtrdevXX+h9Vb8pxFbIheHOtAwMEte7ZLzIG86/8kM7Ni7fFxHK3SZURc4d59dhy
	O4Gt9r8mWg291JPsLJPdwvuytX3M97023SoTu6yTSFz27bbGZg253y+wCwkjTDIhgjX+FP6KGoG
	FROfuZN+3USxrgKEQhUr+sVgkgS9BzEywI+kxpr3fhJdPTEDIV3ZLLzdqefd5WzmXp/DYua4vFE
	X32ToSygUWnTwxwsypfUKFKNZFV+IasdS6sqv+M=
X-Google-Smtp-Source: AGHT+IHIOwX3lqY7JABK9ue4ALK0Ieqr6do6F0vQsDGjJAsb7acNGR+iIOnYpKxLWKRG0Nu0B/+Z1A==
X-Received: by 2002:a05:620a:4245:b0:7b6:c462:6b82 with SMTP id af79cd13be357-7bcd97c99c6mr5609208485a.54.1736979897154;
        Wed, 15 Jan 2025 14:24:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3502a91sm761166785a.84.2025.01.15.14.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 14:24:56 -0800 (PST)
Date: Wed, 15 Jan 2025 17:24:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z4g1tmSqsHmClPiw@gourry-fedora-PF4VCD3F>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z4BMyVsz7bLZAFEy@gourry-fedora-PF4VCD3F>
 <Z4fOrBYzIaIGCq5l@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4fOrBYzIaIGCq5l@rric.localdomain>

On Wed, Jan 15, 2025 at 04:05:16PM +0100, Robert Richter wrote:
> On 09.01.25 17:25:13, Gregory Price wrote:
> > > +	dpa = (hpa & ~(granularity * ways - 1)) / ways
> > > +		+ (hpa & (granularity - 1));
> > 
> > I do not understand this chunk here, we seem to just be chopping the HPA
> > in half to acquire the DPA.  But the value passed in is already a DPA.
> > 
> > dpa = (0x1fffffffff & ~(256 * 2 - 1)) / 2 + (0x1fffffffff & (256 - 1))
> >     =  0xfffffffff
> 
> HPA is:
> 
>  HPA = 2 * 0x2000000000 - 1 = 0x3fffffffff
> 
> Should calculate for a 2-way config to:
> 
>  DPA = 0x1fffffffff.
> 

I'm looking back through all of this again, and I'm not seeing how the
current code is ever capable of ending up with hpa=0x3fffffffff.

Taking an example endpoint in my setup:

[decoder5.0]# cat start size interleave_ways interleave_granularity
0x0
0x2000000000   <- 128GB (half the total 256GB interleaved range)
1              <- this decoder does not apply interleave
256

translating up to a root decoder:

[decoder0.0]# cat start size interleave_ways interleave_granularity
0xc050000000
0x4000000000   <- 256GB (total interleaved capacity)
2              <- interleaved 2 ways, this decoder applies interleave
256


Now looking at the code that actually invokes the translation

static struct device *
cxl_find_auto_decoder(struct cxl_port *port, struct cxl_endpoint_decoder *cxled,
                      struct cxl_region *cxlr)
{
        struct cxl_decoder *cxld = &cxled->cxld;
        struct range hpa = cxld->hpa_range;
	... snip ...
	if (cxl_port_calc_hpa(parent, cxld, &hpa))
		return NULL;
}

or

static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
{
        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
        struct cxl_port *parent, *iter = cxled_to_port(cxled);
        struct range hpa = cxled->cxld.hpa_range;
        struct cxl_decoder *cxld = &cxled->cxld;

        while (1) {
                if (is_cxl_endpoint(iter))
                        cxld = &cxled->cxld;
		...
                /* Translate HPA to the next upper memory domain. */
                if (cxl_port_calc_hpa(parent, cxld, &hpa)) {
		}
		...
	}
	....
}

Both of these will call cxl_port_calc_hpa with
	hpa = [0, 0x1fffffffff]

Resulting in the following

static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
                             struct range *hpa_range)
{
...
        /* Translate HPA to the next upper domain. */
        hpa.start = port->to_hpa(cxld, hpa.start); <---- 0x0
        hpa.end = port->to_hpa(cxld, hpa.end);     <---- 0x1fffffffff
}

So we call:
    to_hpa(decoder5.0, hpa.end)
    to_hpa(decoder5.0, 0x1fffffffff)
                       ^^^^^^^^^^^^^ --- hpa will never be 0x3fffffffff


Should the to_hpa() code be taking an decoder length as an argument?

to_hpa(decoder5.0, range_length, addr) ?

This would actually let us calculate the end of region with the
interleave ways and granularity:

upper_hpa_base  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC) - DPA_MAGIC;
upper_hpa_end   = upper_hpa_base + (range_length * ways) - 1

Without this, you don't have enough information to actually calculate
the upper_hpa_end as you suggested.  The result is the math ends up
chopping the endpoint decoder's range (128GB) in half (64GB).

Below I walk through the translation code with these inputs step by step.

~Gregory

------------------------------------------------------------------------

Walking through the translation code by hand here:

[decoder5.0]# cat start size
0x0
0x2000000000

call:  to_hpa(decoder5.0, 0x1fffffffff)

--- code
    #define DPA_MAGIC       0xd20000
    base = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC);
    spa  = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K);
    spa2 = prm_cxl_dpa_spa(pci_dev, DPA_MAGIC + SZ_16K - SZ_256);

    len = spa - base;
    len2 = spa2 - base;

    /* offset = pos * granularity */
    if (len == SZ_16K && len2 == SZ_16K - SZ_256) {
        ... snip - not taken ...
    } else {
        ways = len / SZ_16K;
        offset = spa & (SZ_16K - 1);
        granularity = (len - len2 - SZ_256) / (ways - 1);
        pos = offset / granularity;
    }
--- end code

At this point in the code i have the following values:

base   = 0xc051a40100
spa    = 0xc051a48100
spa2   = 0xc051a47f00
len    = 0x8000
len2   = 0x7E00
ways   = 2
offset = 256
granularity = 256
pos    = 1

--- code
        base = base - DPA_MAGIC * ways - pos * granularity;
        spa = base + hpa;
--- end code

base   = 0xc051a40100 - 0xd20000 * 2 - 1 * 256
       = 0xc050000000

spa    = base + hpa
       = 0xc050000000 + 0x1fffffffff  <-----
       = 0xe04fffffff                      |

         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	 Isn't this just incorrect? Should it be something like:

	 base + ((hpa & ~(granularity - 1)) * pos)
	      + (hpa & (ways * granularity - 1))

--- code
        dpa = (hpa & ~(granularity * ways - 1)) / ways
                + (hpa & (granularity - 1));
--- end code

dpa = (hpa & ~(granularity * ways - 1)) / ways + (hpa & (granularity - 1));
       ^^^                                ^^^
       0x1fffffffff                     /  2

       We are dividing the endpoint decoder HPA by interleave ways.
       This is how we end up with the truncated size.

 
      Full math
dpa   = (0x1fffffffff & ~(256 * 2 - 1)) / 2 + (0x1fffffffff & (256 - 1))
      = (0x1fffffffff & (0xF...E00) / 2 + (0x1fffffffff & 0xFF)
      = (0x1ffffffe00) / 2 + (0xFF)
      = 0xfffffff00 + 0xff
      = 0xfffffffff

--- code
        offset = hpa & (granularity * ways - 1) & ~(granularity - 1);
        offset -= pos * granularity;
---
offset = (0x1fffffffff & (256 * 2 - 1) & ~(256 - 1)) - (1 * 256)
         (0x1fffffffff & 0x1ff & 0xffffffffffffff00) - 0x100
         (0x1ff & 0xffffffffffffff00) - 0x100
	 0x100 - 0x100
	 0x0


Final Result:
--- code
        spa2 = prm_cxl_dpa_spa(pci_dev, dpa) + offset;
---
     = prm_cxl_dpa_spa(pci_dev, 0xfffffffff) + 0
     = 0xe04fffffff + 0
       ^^^ note that in thise case my emulation gives the exact address
           you seem to suggest that i'll get the closet granularity

	   So if not for my emulation, the offset calculation is wrong?


--------------------------------------------------------------------

For the sake of completeness, here is my PRMT emulation code to show
you that it is doing the translation as-expected.

All this does is just force translation for a particular set of PCI
devices based on the known static CFMW regions. 

Note for onlookers: This patch is extremely dangerous and only applies
to my specific system / interleave configuration.


diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ac74b6f6dad7..8ccf2d5638ed 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -432,6 +432,31 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
        return 0;
 }

+#define MAX_CFMWS (32)
+static unsigned int num_cfmws;
+static unsigned long cfmws_bases[MAX_CFMWS];
+static unsigned long cfmws_sizes[MAX_CFMWS];
+unsigned int cxl_get_num_cfmws(void)
+{
+       return num_cfmws;
+}
+
+unsigned long cxl_get_cfmws_base(unsigned int idx)
+{
+       if (idx >= MAX_CFMWS || idx >= num_cfmws)
+               return ~0;
+
+       return cfmws_bases[idx];
+}
+
+unsigned long cxl_get_cfmws_size(unsigned int idx)
+{
+       if (idx >= MAX_CFMWS || idx >= num_cfmws)
+               return ~0;
+
+       return cfmws_sizes[idx];
+}
+
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
                           const unsigned long end)
 {
@@ -446,10 +471,16 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
                        "Failed to add decode range: [%#llx - %#llx] (%d)\n",
                        cfmws->base_hpa,
                        cfmws->base_hpa + cfmws->window_size - 1, rc);
-       else
+       else {
                dev_dbg(dev, "decode range: node: %d range [%#llx - %#llx]\n",
                        phys_to_target_node(cfmws->base_hpa), cfmws->base_hpa,
                        cfmws->base_hpa + cfmws->window_size - 1);
+               if (num_cfmws < MAX_CFMWS) {
+                       cfmws_bases[num_cfmws] = cfmws->base_hpa;
+                       cfmws_sizes[num_cfmws] = cfmws->window_size;
+                       num_cfmws++;
+               }
+       }

        /* never fail cxl_acpi load for a single window failure */
        return 0;
diff --git a/drivers/cxl/core/amd.c b/drivers/cxl/core/amd.c
index 553b7d0caefd..08a5bfb9fbd6 100644
--- a/drivers/cxl/core/amd.c
+++ b/drivers/cxl/core/amd.c
@@ -64,6 +64,10 @@ struct prm_cxl_dpa_spa_data {
 static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
 {
        struct prm_cxl_dpa_spa_data data;
+       unsigned int cfmws_nr;
+       unsigned int idx;
+       unsigned long offset, size;
+       unsigned int dev;
        u64 spa;
        int rc;

@@ -75,12 +79,35 @@ static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
                .out     = &spa,
        };

+       cfmws_nr = cxl_get_num_cfmws();
+       if (!cfmws_nr)
+               goto try_prmt;
+
+       /* HACK: Calculate the interleaved offset and find the matching base */
+       if (pci_dev->bus->number != 0xe1 && pci_dev->bus->number != 0xc1)
+               goto try_prmt;
+
+       dev = pci_dev->bus->number == 0xe1 ? 0 : 1;
+       offset = (0x100 * (((dpa >> 8) * 2) + dev)) + (dpa & 0xff);
+
+       for (idx = 0; idx < cfmws_nr; idx++) {
+               size = cxl_get_cfmws_size(idx);
+               if (offset < size) {
+                       spa = cxl_get_cfmws_base(idx) + offset;
+                       goto out;
+               }
+               offset -= size;
+       }
+       /* We failed, fall back to calling the PRMT */
+try_prmt:
+
        rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
        if (rc) {
                pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
                return ULLONG_MAX;
        }

+out:
        pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);

        return spa;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f93eb464fc97..48cbfa68d739 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -919,6 +919,10 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);

 struct cxl_mem_command *cxl_find_feature_command(u16 opcode);

+unsigned int cxl_get_num_cfmws(void);
+unsigned long cxl_get_cfmws_base(unsigned int idx);
+unsigned long cxl_get_cfmws_size(unsigned int idx);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.

