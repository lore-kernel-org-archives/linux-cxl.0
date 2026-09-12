Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBB2332610
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.248.84.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789205129; cv=none; b=J5tDjz/e4T0PITpRDASf4PHX1NF41ZzK4nDr62WVdpXYncP74B85EFomwHVOjP3mBEmxfnWrNA0KKD2aMqwoWAlyGpN4XR8RmGbeSx423TD9mZT9DyonOKE15j7cNI2RXxIUgn2u8lOZ3EfsJjlfYtzC6se4IkNMSqsVvx5IKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789205129; c=relaxed/simple;
	bh=yEf6zrh0FkpBp5VRN9w7S5TZ0QWnGIeRGwTsdvItsZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnWMKlgVPaAN8qB0C1Gq8TUH9W46pNtCwdZMW/1LM1HqXrV9wuHMODWHtIpk2xhMugqX/PBDDDUh3NP4rTSTgx0hrF+PTYvI2PgajXe0llVlAYDeJLhaYiDSOiqulgjNTI5E3+ajB0acDTs67dRlp9DjYVMOGZZLH/Aj0AzPLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru; spf=pass smtp.mailfrom=tls.msk.ru; dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b=tzbzAsCp; arc=none smtp.client-ip=212.248.84.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.b="tzbzAsCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1789204607; bh=yEf6zrh0FkpBp5VRN9w7S5TZ0QWnGIeRGwTsdvItsZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=tzbzAsCpqXF5DN9y/6GxVvoQjRjyWfhfCGc/QmVVNj7JNbZjbYgqTv1p/KZGEXivr
	 LQnsOZzoqKTWjskTVTeF/uR40YNvyHQZMGME5sC5zR8WMfbqDxDXgu1xCrQ4dnHcM+
	 nTHXBuUQF+JIebXlYcK+Ui9nN6y8CxuANsW1D4NimBh4+7HjNboOTenLa5Q4C6B8rf
	 RaU/fYZqndG/v3DbYWf716+yWWUeMelcJl4iarQx0BD9NJl/IRWZRYUSAY1DIr5CEP
	 Ejs+7e0JDIjHTdOoZgoeFBgmRbf62vG3j8TQMf6UiiBDenFAK7Xl55+uHK71TwMtp9
	 S+s7lYYXfodtw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id A37631D3F8D;
	Sat, 12 Sep 2026 12:16:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 399684264D8;
	Sat, 12 Sep 2026 12:17:22 +0300 (MSK)
Message-ID: <408b15ae-4a61-4082-9b19-800f2f934bcc@tls.msk.ru>
Date: Sat, 12 Sep 2026 12:17:22 +0300
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] hw/cxl: fix the CDAT DOE overlapping the Flex Bus DVSEC
 when sn= is set
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: mst@redhat.com, Shrihari E S <shrihari.s@samsung.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260831022302.406740-1-junjie.cao@intel.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260831022302.406740-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/31/26 05:23, Junjie Cao wrote:
> ct3_realize() adds the CDAT DOE at a fixed 0x190.  Since 8700ee15de the
> four DVSECs take 0x90 bytes, which from 0x100 ends exactly at 0x190.
> With sn= the Device Serial Number capability pushes the block to
> 0x10c..0x19c, and the DOE, added later, overwrites the last 12 bytes of
> the Flex Bus Port DVSEC: Capability2, Control2 and Status2.  Nothing
> catches this -- pcie_add_capability() checks bounds, not overlap, and
> the chain still walks because the DVSEC's next pointer becomes 0x190,
> inside its own body.  Most cxl-type3 examples in
> docs/system/devices/cxl.rst set sn=.
> 
> Derive the offset from the DVSEC block instead, as cxl_upstream.c
> already does.  Without sn= the layout is unchanged byte for byte; with
> sn= the DOE moves to 0x19c, below the AER capability at 0x200.  The
> type 3 device has no VMStateDescription, so its config space never
> reaches the migration stream.
> 
> Fixes: 8700ee15de ("hw/cxl: Standardize all references on CXL r3.1 and minor updates")
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

This feels like a qemu-stable material.  I'm picking it up, but please
have qemu-stable@ in mind when the change is worth picking up for the
older stable releases.  And please let me know if I should not pick it up.

Thanks,

/mjt

> ---
> Found while walking the extended capability chains for the UIO/SVC RFC
> V2 review; independent of that series.
> 
> Tested at bde2492aac on q35 (pxb-cxl / cxl-rp / cxl-type3), dumping the
> capability chain and raw config bytes from the guest with and without
> sn=: the Flex Bus DVSEC keeps its full 0x20 bytes and the DOE sits at
> 0x19c; without sn= the bytes are identical before and after.  cxl-test
> 12/12.
> 
> On cxl-2026-03-25-draft REG_LOC_DVSEC_LENGTH is 0x34, so the overlap is
> there without sn= too; with this change the DOE lands at 0x1a0/0x1ac.
> cxl-2026-01-09-draft also fixes doe_comp at 0x1b0, which would then
> collide -- the two want chaining.
> 
>   hw/mem/cxl_type3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 28f41fa623..e6eb2e0cba 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -936,8 +936,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>       }
>   
>       /* DOE Initialization */
> -    pcie_doe_init(pci_dev, &ct3d->doe_cdat, 0x190, doe_cdat_prot, true,
> -                  CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
> +    pcie_doe_init(pci_dev, &ct3d->doe_cdat, cxl_cstate->dvsec_offset,
> +                  doe_cdat_prot, true, CXL_T3_MSIX_PCIE_DOE_TABLE_ACCESS);
>   
>       cxl_cstate->cdat.build_cdat_table = ct3_build_cdat_table;
>       cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
> 
> base-commit: d2e570cc0f97b936902a5b1b86b73c0f5998b475

