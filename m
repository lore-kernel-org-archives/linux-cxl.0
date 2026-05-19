Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3164A3403F7;
	Tue, 19 May 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195871; cv=none; b=ZNVpVvxunZWBxxehJaLlZTHcDZFPiB872WWwA0634vKVLpS8YxeGp5e9v/79uCQeCKFs0aX1+Yvv5VSHEeyw/t0XRNCD3LIMWyvQEWkjwGt7HDaacfbN17lg9Jgc51iH5+PeNTLhQuvJJo1EmoRy1eJxID18n/kOLWX0bIvaO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195871; c=relaxed/simple;
	bh=s7r31IRZbFW16C9VKh1NJLg1y0aRrzKMqmXg2we0mO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arHHr4Z7Rh2tz9mFHyuQw6sa3ODPN36qGooChYqbYW58NEGnCpPp+0hv/Tl5I6yvAMTcadEwOc9UyV21GBwwfCqep2RVVFrcy1e6H3+z750RPzOMFe05QYTcWTvF+WtX39tCTD+utQprcPAz7hb5iRcdZtWArG4mQC4RZIlvb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJCeA0kx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJCeA0kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A32C2BCB3;
	Tue, 19 May 2026 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779195870;
	bh=s7r31IRZbFW16C9VKh1NJLg1y0aRrzKMqmXg2we0mO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJCeA0kxJyb1vjWmlhH2TMLG4bHfvhTNXN5f8sbs3oMfBBpDBqSzHBv010seCgBtC
	 zkmbSZKS7Vz+w0a3G/isUa2Hhh6tTrSfcbrZCSHIu9VzSHZxKYUI3MDUXuGYOb+Yak
	 VDH/0ahWvf1FuYhIBwNxUMJm/GbCCjD3+iK7aDKH962hPko1PIf4pmHZCzuy4xvsdr
	 7YFmoX4HEXbsTaKCIgyu3KeDEXhA73w8sa7bZZUtPgmYj6GJvcLpgw+MFUhqpb/IH4
	 SEu+ukr+Z5doLMvg74+En6PpOvrxMksQonkwjHFDLLpcCO36jCGnAnUGSRL5GQBjfs
	 TrlKC/uYJ7Eaw==
Date: Tue, 19 May 2026 14:04:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>,
 <ankita@nvidia.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <clg@redhat.com>, <cohuck@redhat.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC 7/9] hw/vfio+cxl: Program HDM decoder 0 at machine_done
 for firmware-committed devices
Message-ID: <20260519140416.02a793ce@jic23-huawei>
In-Reply-To: <20260427181235.3003865-8-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
	<20260427181235.3003865-8-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 23:42:33 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> setup_locked_hdm() runs as a machine_done notifier after all devices
> have been realized. It programs HDM decoder 0 with the CFMWS base

Be more specific on this.  Which HDM Decoder?  i.e. what device
is it in.  Ultimately there may be several in the path.  Are you
supporting that?  The reference to FLR() later would only apply to
an endpoint (can't FLR a host bridge) + the code is clearly operating
on the shadow registers for the EP.

I guess maybe you are relying on pass through host bridge decoders?
If you are - you need to go check those - or better yet program
and lock them as well.

> address so the guest can fault into device memory from the first
> instruction.
> 
> The notifier is only registered when the kernel reports the device as
> firmware-committed (VFIO_CXL_CAP_FIRMWARE_COMMITTED). The host is
> responsible for HDM decoder programming; the guest has no mechanism to
> remap host physical address mappings.

Maybe say why this matters.  Presumably because only thing we can
program from the guest is GPA to HPA mappings so linear ranges remain
linear etc (more or less anyway given constraints on how many
regions we can plug into qemu!)

> 
> The function uses cxl->fmws_base (set by the optional cxl-fmws-base
> device property) if non-zero; otherwise it falls back to the

Why is that property needed?  If it is add it in a separate patch where
you can explain the need to force it. Smells like a hack so far.

> cxl_fmws_base global captured by cxl_fmws_set_memmap() during machine
> memory-map init. If neither is set, it warns and returns without
> programming anything.

Which CFMWS is that base in?  How is that controlled?  We may well
have some type 3 devices in same VM and probably want those in different
CFMWs (we'll need to actually upstream the patch to control constraints
so the kernel won't try using your CFMWS for those - currently all CFMWS
are entirely flexible).


> 
> If COMMIT_LOCK is set in decoder 0 CTRL at machine_done time (left-over
> from a prior FLR?), it is cleared before writing BASE so the subsequent
> write is not blocked. COMMIT_LOCK is re-set after programming so the
> hardware enforces the committed base.

Hmm. We should look into whether there is a correct way to reset that.
Though as above from the description I'm not sure which decoder this
is resetting.

> 
> read_region() return is checked; failure aborts programming rather than
> leaving ctrl uninitialized. All write_region() failures are propagated.
> The function exits cleanly rather than leaving the decoder half-programmed.
> 
> Add cxl_fmws_base as a hwaddr global in cxl-host.c (and a stub in
> cxl-host-stubs.c). It is set once by cxl_fmws_set_memmap() and read
> later at machine_done time.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>


> @@ -3486,6 +3646,18 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev, Error **errp)
>      trace_vfio_cxl_setup_params(vbasedev->name, cxl->hdm_regs_bar_index,
>                                   cxl->hdm_regs_offset, cxl->hdm_regs_size,
>                                   cxl->dpa_size);
> +
> +    /*
> +     * Only pre-program the HDM decoder if the kernel reported the device as
> +     * firmware-committed.  Non-committed devices need guest driver involvement

For wording these can we be very clear which kernel.  Though I'm also unsure
what FIRMWARE_COMMITTED means here.  Does it actually mean host firmware, or does
it mean something running on the host pre guest boot (e.g. could it be qemu?)

> +     * to commit the decoder; registering the notifier for them would write an
> +     * uncommitted BASE value that the hardware ignores.
> +     */
> +    if (cap->flags & VFIO_CXL_CAP_FIRMWARE_COMMITTED) {
> +        cxl->machine_done.notify = setup_locked_hdm;
> +        qemu_add_machine_init_done_notifier(&cxl->machine_done);
> +    }
> +
>      return true;
>  }
>  


