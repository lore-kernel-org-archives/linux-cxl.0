Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D13AFCEB
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203007; cv=none; b=CanFmIzCdqrTjzfRNmfb7+TfC3Ki1HcQ3ZS3fw6+c7ZvdRL/fgmsVV/3DF6uhAIX/gJTSrjrZT4ply8EprIIMflTGW1RZkIINXnOxOYb5kCK0NSWd98vHHVl1NMfNUwtQNFYlVOoHuD0l+JgqChPAA3gxf+ZLcNqR/FVz7UQCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203007; c=relaxed/simple;
	bh=QpFFRAEmgJSwq4mHaasEexckCHQ/SH+TpXJyOShu0ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouX0d8ysp3ZXeYc3TwEY+xm3W6AEzLBhI8SZgPHWZDanG4GBRfUEfGAxlk/qalgBk6kjUUO0N62CTOC8twB9xNyQZsp8G+rvyEnSgOTgZNzuiyNIk0tEH3cKGEJMLydLJpnpCE+ZLXqAgBar5LUWKGt9AgAhnC+cX8VuWfPA3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKbhN3Mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKbhN3Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C36BC2BCB3;
	Tue, 19 May 2026 15:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203006;
	bh=QpFFRAEmgJSwq4mHaasEexckCHQ/SH+TpXJyOShu0ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKbhN3Mkw4cGHmWwOhS0G7Uu5ceAdPg8M3pFp01WWLsWcCTE+/nSks99VxjTt1+CC
	 Wzf6JNkfBU2+nvPh+PnHXnMpk5acKuwwPuvMNFrWQTl8Ij/wphC/fmL38GDRMlvVti
	 1/X7TrO1EVmvZD9gdyGypQJ3BQvXQ/CZCScVZTLo5GSSj1Ank/Ci25sZ2gX8RRwN84
	 IJrCFWSF3KMidWNPJR9xddxUU+Y/Dh2jyat58xXD7H7E+5U/MF3s1I9cFHmPbGZOd0
	 /M+NBLgykya9ZUN9DMFiEgjKGhmY7qgHn4nFMnPWL4uXRPjQLBppVX1KzBLqthn0RK
	 qcK5OLwfVLHTQ==
Date: Tue, 19 May 2026 16:03:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 04/10] cxl_downstream: enable power controller
 present capability.
Message-ID: <20260519160318.24091832@jic23-huawei>
In-Reply-To: <20260429135717.3048713-5-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
	<20260429135717.3048713-5-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 14:48:38 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> PCI_EXP_SLTCAP_PCP (Power Controller Present) must be set in the DSP's
> slot capabilities for PCIe managed hot-remove to complete. Without this
> notification from the guest of removal cannot be sent back to the
> device, so device listeners for unrealizing will not fire.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>
Another fix by the sound of it?  Please send separately (Well with the other
one perhaps) with a suitable Fixes tag.


> ---
>  hw/pci-bridge/cxl_downstream.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 91c5e6a605..5322c46900 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -228,6 +228,8 @@ static const Property cxl_dsp_props[] = {
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_16),
>      DEFINE_PROP_BOOL("x-256b-flit", PCIESlot, flitmode, true),
> +    DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
> +                    QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>  };
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)

