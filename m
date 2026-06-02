Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34573EFFC8
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411088; cv=none; b=NVMgTIEfE8KKeo59GCDhnJp/dSsCUVQ7TuefpUrtBASBoH07ZngNYTplnpuhk/wNYSSiLo2Om2PFbuveNwqKqV/pgdfwHTJdX/x4r4NVR5VH8Ce9Q1X/CrqmWyE7j2od7cJEJ5qqr1WA9C6rySS+HXrmfEztBOEf4uk3rsrMHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411088; c=relaxed/simple;
	bh=UszHQAFwH/u+inOuF7+ZusVKaCVjvvUfkqVfCaBTeRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjGU+IxH1lKf2l3hs11dJD7Or8RglJ9/SZGOYBk+dd4juA/H5QXvQkDPzN7ioKyf1kGGQDjfGunaP4/HfezPV68f4Z8QfBXcPO+Goy+67ooqYyKkaJMb2ODojdBWNTOhioHCDj5+7tkLshP5Lu7knLpFFl/EHMzi3J5Jbx88EKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE3q/get; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE3q/get"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AF01F00893;
	Tue,  2 Jun 2026 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780411087;
	bh=v1WMeXKskUaXSuwNsyVzxqgC4aNDlUoxHgrmCj9WRr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lE3q/getv2Zn+jRRgHrGVtRcE6BxO68oWoxXqgQEaMYdav+sXbpTmhkBzXobArSVq
	 lXmXM+phLLaeOnPEbtCMXvkeHGIt1Y9HIvhIEoZPyxVXL7q5jVWg7EqFaXaycdFs7g
	 LSWDV8q8zz11KtvUsUgLj1zZWgkj6VBQfKsIeLSlm5qhVmqlD0Ixl2NOjIIVJkxb0a
	 X3VauI3bpZHMMbl4kOwCDUo4bMGHrDCjSS+0rOnbukD62Q0LW4OMq2V/Z6oHhR2sfm
	 mPHycdpWnYBhMzgrS4VC5liYS+otnuxMrZmMGHZSOcmqm9y+fMy/PqcJouBBGjlF4V
	 eI82gga7dlxqA==
Date: Tue, 2 Jun 2026 15:38:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH -qemu] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Message-ID: <20260602153803.322bf993@jic23-huawei>
In-Reply-To: <20260602043029.2341246-1-dave@stgolabs.net>
References: <20260602043029.2341246-1-dave@stgolabs.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 21:30:29 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Change the default CXL Fixed Memory Window restrictions from
> 0x2f to 0xe, dropping Device Coherent and Back-Invalidate,
> which are considered spec violations when using in combination
> with host-only.
> 
> For HDM-D and HDM-DB models, the user will need to explicitly
> pass the correct restrictions bitmask.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

So this only applies on my staging qemu tree (as the
restrictions control patch is not upstream yet). Would you mind
also doing a fix for mainline qemu as we need to change the default
prior to that restrictions patch?

For anyone wondering why that isn't upstream yet - it is mostly
a question of working out a better command line than writing the 
bitmap.  Probably as set of flags for each thing with checks
to ensure we don't end up with impossible combinations.

If you have time to look at that Davidlohr, would be much appreciated.
Without it the BI stuff in upstream qemu will be untestable.

Jonathan

> ---
>  docs/system/devices/cxl.rst | 5 +++--
>  hw/cxl/cxl-host.c           | 2 +-
>  qapi/machine.json           | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index 32b1b5d7733b..079f65660dc3 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -385,7 +385,8 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
>  An example of 4 type3 devices with volatile memory below a switch. Two of the devices
> -use HDM-DB for coherence, which requires operating in Flit mode::
> +use HDM-DB for coherence, which requires operating in Flit mode with the CXL Window
> +configured with Back-Invalidate restrictions::
>  
>    qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>    ...
> @@ -405,7 +406,7 @@ use HDM-DB for coherence, which requires operating in Flit mode::
>    -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
>    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>    -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
> -  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k,cxl-fmw.0.restrictions=0x2d
>  
>  A simple arm/virt example featuring a single direct connected CXL Type 3
>  Volatile Memory device::
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 11a455b28ab8..a2595633ff0c 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
>      if (object->has_restrictions) {
>          fw->restrictions = object->restrictions;
>      } else {
> -        fw->restrictions = 0x2f; /* No restrictions */
> +        fw->restrictions = 0xe; /* host-only coherent, volatile, pmem */
>      }
>  
>      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 11ce0457d2f1..f832f0b84a53 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -558,7 +558,7 @@
>  #     BIT(3) - Persistent
>  #     BIT(4) - Fixed Device Config
>  #     BIT(5) - BI
> -#     Default is 0x2F
> +#     Default is 0xE
>  #
>  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
>  #     root bridge.

