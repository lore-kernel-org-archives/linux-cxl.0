Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149708;
	b=SwXnpopt7Crcu3AAQcF71zOqj0euxmHtnhru6EPncU7PcPuhzlCcSIm1z11eeGWoeW6v
	 zTsIV4xKzJc4u0TRd6t12nZ7YRD+nLGYz7/Kl7BZCysJ5+yJIO+fALVC0r93W/RXJTKrA
	 ujf2BXhXAoUVBMzc9h8qalfqrLiQyitxHWaOe+cuV0t9WdluwOn/p/wfRYtZWM9UoZVWa
	 twAWbbptFlfZgbONyy+bHIZBY6fJePw0HOKPPbmIArz3fYbrLVElBc9gbrMECwsnU9WC7
	 4IdofEDhxYU4Ul2i3PHMvl+RfFcF1I4Q4utC7L0fs2IyV9eytKt3fi4cIo28D3+c1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=FpR5vVi8uAfWfF2ulvEpP4ok4aRKEHsd8aW1c5L0HNI=;
	b=z/+U+tlgQaMaq0Ct84NFTH2MTTclaYjZt9zkS4DC5tr+L86TcDl9x2jlU9R14OF/wwCw
	 IlcZyHUoRfQeJlgFp4ojbhVMNwV2u+MWrOaGdJYv6NwzCMc4pOoZNz7dahwHL6S8HpHvX
	 PmAkMdCBnVTKO16NXz6a2XBr9k/Ld0CPR664csJ8/7Bk+XoP/pDMaBwAsBfa5gi32+AfX
	 hEvxSqwoeMKFzYdGaD8m7AdlJfO9fFFyedfD96HK48Uhnlml89ZtDhAoCg4yFc72eGGk5
	 4JorekQ4DkKZt9VvXSPP8g91/ozwqv7Gf/p5VhM1KWWTQ+Z9GYqnWnR+XjflKUpS3/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGeuOveU;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2A606A31A
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 01:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC2A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGeuOveU
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2761c69fbso951835c88.0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793149707; x=1793754507; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpR5vVi8uAfWfF2ulvEpP4ok4aRKEHsd8aW1c5L0HNI=;
        b=uGeuOveUEHrE9hGJ1qNIDuUd8BBOKD28Bd6XxRY0yKwe7KFUESh1puTmFrooI9y0YZ
         XiFtHPmO3UjILJ2S+ST5hfdArnhxzmAWYTOjA1haNmw1RKSDBFxfEgjXOJphEV55K1cw
         Fci+d5/X+Cy6IReHMAEt7Lu1I7TiM53sVm1DgZluAsiYHZ40bUaMWsnYWx0IYbuKqmRY
         /N8hT73ShC0UeHa6tjjVOclH9P5pYYKqKQPahBtjXyu2w5xqTDJ71nIXLVG4yELum6LG
         E9FIR/RDsyLVsPYJTy49tU7OqhCKN1txNGSsrIoPIWDPCgglxGg33FSuObPU541ZQp0U
         YBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793149707; x=1793754507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FpR5vVi8uAfWfF2ulvEpP4ok4aRKEHsd8aW1c5L0HNI=;
        b=vTDiva2bZ9WltT/10HOIS1gpYBs0Q4b0+oVKkHeWITFHIGbJM842pCJmDk8Yq1TAOS
         5TrIM59FHKQfaekMYEsY4xL4OlVRFhBdW7RTbtDKUec8eZFNKb5J3hv8jBKSjxyiJyxy
         9KXlfnhAAXoTab1vvXPBharnDfeO6ByFFl/7HQd+QVVlquwHw3YcO0aCwd9Jywe+vRtx
         AA7L+1n/Iu9S8WEiT15WOcGTbYqAh9vZJWj/xcBSD/45RcKcxcHn7LYwHJYsrAfPBomd
         JN22GH70RNtudC5WKZvAz1qtDtEuhZfOmVhXUReSMSJVki25PIPjx5G4uNhKi+Kx4O2T
         512A==
X-Forwarded-Encrypted: i=1; AKwUvBxekd5n09SvZG1hejHDBgKQ2Ol4uBERllNfwU9WjQg3nDe/mvt8WEKJsFIwdhlMR4A/DCbbQYugYoI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIkS+gp64y8uL/i/j5e4mIGTh5CKtVLh9mqVzbzwPCchJftY8B6
	Lw6MxgRCqo23xrAn4zpyES/XnBNCfehrZz2wWKNicbYooAWvllDvJByN
X-Gm-Gg: AYBFou3N9EnEq5ZgcgRWISK3tl6b1+LYPQsYNcmRHzOaQq0bae4J5v79U2gOJr8K2eD
	u6TEd+niGocoLrhZRPBO7pN8HTt8iUae1nKxFI5BZvjYuX/ExhMBrG/u1kTh2ofghqI+F/36cfi
	YUZcIOF9r8X9pdUfq4m7gHbTjjCX7ni3B92+2Wbc8AxrRCzUTS81XOr2SOkA9oqrWqTUXMDoiz0
	jsE8tW6f+0iJAsxC83oUkOcnpIQ271kK9aMRFy2iXSBzeFgomLs/J+MfA/cNP/XhFeXBctiytPJ
	EZYiRUPYaee/rvtD155bH1wmw4KQ3a6q4kCtuQ7sMJCDuTuFojLjSNVogbaaVio1aUdrkLQRN36
	xJOjEiGK6DikR19CNJus1ZVXzifdO15qjb/AsMwBzSbe7g1U65VTdrVEzQjrI296Dc/LtGsHuSY
	JymHsMNFtUZzUAaeZNBB0c45dgKInXeCX/4ngCcfe0DMjjzrx+nFMdULEP6E7KlIjUWdMEaZgF6
	o9d4SYnGffAKH5Sn8PYFCrkwEnyCGNGF9xaYIrQPgWOBJLf5T8WhvXN2OvwUTa+aEy9mk2CK5/e
	3gYY3jvnpg9Yr7mwbRUOd4sU
X-Received: by 2002:a05:7022:32b:b0:19b:1202:77f8 with SMTP id a92af1059eb24-1a6ce2ff0b1mr1423872c88.32.1793149706626;
        Tue, 27 Oct 2026 18:08:26 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75a64fe0fsm835463c88.1.2026.10.27.18.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:08:26 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 28 Oct 2026 10:09:54 +0900
To: Yukiya Takaki <fj2110jc@fujitsu.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>, linux-cxl@vger.kernel.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>, lizhijian@fujitsu.com,
	y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: Re: [PATCH RFC 3/7] QEMU: hw/cxl: add helper to get HPA range for
 CXL Type 3
Message-ID: <auFLYiiwDiuXaHfZ@cxlqual>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
 <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22b52860497f643217fb52f029d87ebd8a6e6492.1793003983.git.fj2110jc@fujitsu.com>

On Mon, Oct 26, 2026 at 07:03:24PM +0900, Yukiya Takaki wrote:
> The previously added `hpa_offset` on CXLType3Dev records the offset of a
> device within its CFMW window, but there is no simple helper to obtain the
> full host physical address (HPA) range for a given Type 3 device.
> 
> This patch adds `ct3_type3_get_hpm_range()`, which returns the HPA base and
> size for a CXLType3Dev by combining the CFMW base, the per‑device offset
> and the device size. The helper is declared in the header so that other
> code can use it when building tables and regions.
> 
> Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
> ---
>  hw/mem/cxl_type3.c          | 40 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  2 files changed, 41 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d08a4255c9..811f8e247d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1358,6 +1358,46 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>      return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
>  
> +static uint64_t c3t_addr_size(DeviceState *dev)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(dev);
> +    MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +
I think the reason program-hdm-decoder=true fails on CXL PMEM
topologies as you mentioned in the cover letter is because this function only
calculates size from ct3d->hostvmem, which will pass NULL to
memory_region_size() here.

RAM and PMEM size is already calculated in cxl_setup_memory() in
ct3d->cxl_dstate.static_mem_size

I think this helper can be deleted by directly using static_mem_size in 
ct3_type3_get_hpm_range().

Or if you prefer not to support PMEM for this feature at all, you can
reject it in patch 2:

static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp) {
...
if (ct3d->program_hdm_decoder &&
        (!ct3d->hostvmem || ct3d->hostpmem || ct3d->dc.num_regions)) {
        error_setg(errp, "program-hdm-decoder requires volatile-memdev "
                         "and no persistent or dynamic capacity");
        return false;
    }

}
> +    return memory_region_size(vmr);
> +}
> +
> +static uint64_t c3t_hpa_base(DeviceState *dev)
> +{
> +    GSList *cfmws_list, *iter;
> +
> +    cfmws_list = cxl_fmws_get_all_sorted();
> +    for (iter = cfmws_list; iter; iter = iter->next) {
> +        struct CXLFixedWindow *fw;
> +
> +        if (!object_dynamic_cast(iter->data, TYPE_CXL_FMW)) {
> +            continue;
> +        }
> +        fw = CXL_FMW(iter->data);
> +
> +        PXBCXLDev *pxb = fw->target_hbs[0];
> +        if (ct3d_to_cxl_pxb(dev) != pxb->cxl_host_bridge) {
> +            continue;
> +        }
> +
> +        g_slist_free(cfmws_list);
> +        return fw->base;
> +    }
> +    g_slist_free(cfmws_list);
> +
> +    return 0;
> +}
> +
> +void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size)
> +{
> +    *base = c3t_hpa_base(DEVICE(dev)) + dev->hpa_offset;
> +    *size = c3t_addr_size(DEVICE(dev));
	*size = dev->cxl_dstate.static_mem_size;

Thanks,
Anisa

> +}
> +
>  static void ct3d_reset(DeviceState *dev)
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(dev);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index c3a729f8c5..07654f4b62 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -878,6 +878,7 @@ void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                     uint64_t len);
>  bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
>                                    uint64_t len);
> +void ct3_type3_get_hpm_range(CXLType3Dev *dev, uint64_t *base, uint64_t *size);
>  void cxl_assign_event_header(CXLEventRecordHdr *hdr,
>                               const QemuUUID *uuid, uint32_t flags,
>                               uint8_t length, uint64_t timestamp,
> -- 
> 2.52.0
> 
