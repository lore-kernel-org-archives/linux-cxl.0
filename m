Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13E2343BE
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784595492; cv=none; b=Zj8hh+9ZurxZIJMWpHysoD+o7vjtB1IQMAXuDYlZWDLfCt1edG/QvbtP2eBS+VC6IaGFpbKP4igSaz9Agq7WapEFeWKUvyAYOEOWNv/o4VNgz/j4HetxpizGq0VI0fp1QRktQtJUqQxHpz4YJ7WbTCPWKkbatgzpkRnCWdTdVKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784595492; c=relaxed/simple;
	bh=MGC4Hu4VzganbjKYiVcqYiPzq0jtWyQ2ER6LtbU0sLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QN4dLrErwQ3HarLxdou/duSIebbU+pknx0kYvoYzS9/DLMOHD5wjW3d+t88XdTa65gtfFYM3lzIVn+A7u+ReUvY+d6oFnITLSJsQAIHUW9kvhhjsnGJ3Uwip4VkqTvYYj9XkYP/T/830a+KJ7x1WFxAVmSqmo2xk/J9xmY4G8/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8BKWV/+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8BKWV/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604D91F000E9;
	Tue, 21 Jul 2026 00:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784595491;
	bh=G2/ahlTAuc92u9ADBlHv6kLK15vxyrSA5dqACaKvJp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d8BKWV/+X/0dFy6lGameB3hVa09u6KNE8Fr/briSAOQHDL1FKmQri1vx7Pme6GP4H
	 S4UwS4EuoveV8AqW3fqFb9wpRo5+xxe5fH+nAPemjbuSP/FHAgCXa9vqI8WIROzqWV
	 ViBmZHhPYMdAb5DkbODHsusDYM6SrEdPmgBBRCQjUxomWZTLwQg4AItxWDQlk7/gpX
	 r3mue2yIMsVXaSKu/pX7EZmP3rKhreJU11CkSEO4MIWF2YfA689hmDkznRzlLD2Aae
	 omeGPR1fBfpBsQp6KhllNItmWaMyUX6hELe0AfLcuC2esDWydsvwdsJWTg60DAzb2F
	 gnvyxOF0GJIsw==
Date: Tue, 21 Jul 2026 01:58:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: jianghaotian.sunday@gmail.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, linux-cxl@vger.kernel.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 1/1] hw/cxl: fix OOB access in cxl_doe_cdat_rsp via
 entry_handle
Message-ID: <20260721015805.616e869a@jic23-huawei>
In-Reply-To: <20260713072336.623604-2-jianghaotian.sunday@gmail.com>
References: <20260713072336.623604-1-jianghaotian.sunday@gmail.com>
	<20260713072336.623604-2-jianghaotian.sunday@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 15:23:36 +0800
jianghaotian.sunday@gmail.com wrote:

> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
> 
> cxl_doe_cdat_rsp() takes ent = req->entry_handle (uint16_t, fully
> guest-controlled, 0..0xFFFF) and directly indexes cdat->entry[ent]
> without checking ent < cdat->entry_len. For a default cxl-type3 with
> one volatile memory region, entry_len = 1 + CT3_CDAT_NUM_ENTRIES = 7,
> so any entry_handle >= 7 reads past the CDATEntry array into host heap.
> 
> The OOB-read base/length are then used in
> memcpy(read_mbox + offset, base, len) at cxl_type3.c:298-299, leaking
> host heap memory to the guest via PCI_EXP_DOE_RD_DATA_MBOX, and
> potentially overflowing the 1 MiB read_mbox heap buffer when the OOB
> length field is large.
> 
> The same bug exists in the cxl-upstream implementation.
> 
> Existing checks do not bound ent: assert(cdat->entry_len) only ensures
> the table is loaded; the minimum-length check only guards against a
> truncated CDATReq; the entry_handle ternary at line 293 only decides
> the next-handle echo, not the current access; pcie_doe_get_obj_len
> reads header.length, not entry_handle.
> 
> Reproduce: build QEMU with CONFIG_CXL, boot
>   -M q35,cxl=on -device pxb-cxl,bus_nr=52 ... -device cxl-type3,...
> then send a CDATReq with entry_handle=0xFFFF via the DOE mailbox at
> config offset 0x190. Under ASAN this reports SEGV in cxl_doe_cdat_rsp
> at cxl_type3.c:281.
> 
> Fixes: f5ee7413d5 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> Fixes: 882877fc35 ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org

Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Will be a little while before I can spin up a staging tree, so Michael,
if you want to pick this up directly that would be great.

Thanks,

Jonathan

> ---
>  hw/mem/cxl_type3.c           | 3 +++
>  hw/pci-bridge/cxl_upstream.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index cba05ec57d..28f41fa623 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -278,6 +278,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
>      }
>  
>      ent = req->entry_handle;
> +    if (ent >= cdat->entry_len) {
> +        return false;
> +    }

Blank line here ideally.

>      base = cdat->entry[ent].base;
>      len = cdat->entry[ent].length;
>  
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index b6281cbd4c..69773ff163 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -158,6 +158,9 @@ static bool cxl_doe_cdat_rsp(DOECap *doe_cap)
>      }
>  
>      ent = req->entry_handle;
> +    if (ent >= cdat->entry_len) {
> +        return false;
> +    }
>      base = cdat->entry[ent].base;
>      len = cdat->entry[ent].length;
>  

