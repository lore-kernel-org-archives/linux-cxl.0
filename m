Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415953AFCF1
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202904; cv=none; b=rsVXMGP0uRoFQkuSTIuWF2twOYV7QP6OE4uEThaC1I43LbYQDTVle6N0p6jl6RhVEPYEUCxEOb7TiuPl3D1M12f5TddBMoDypA7wo8FTFkALVLCOeKByydMc1L+u49vqPAxTexv30cY1Tsfp4jk/80uVdAeDmZKKH4/pmN2NLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202904; c=relaxed/simple;
	bh=1LeZ7aaDt0fOQkBu34KD+Jm+fXwQzL0U0/52fSh7Sao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTwp+HuDZT3PS5I/D44X38Tjbx8qLxFsnlTroJT29WsPvF3OV8I0amxtBSPFaRnzMRcLCFx30YhG8KYjS4KJhyfvkEdhy9Y5fVYuuceUBnzYtOWPOrnY5u/2PiiICS9qwdLSOLKUImWwJJoy1c0hdY9SyOVO5YFw1q534R42OmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5T3NDjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5T3NDjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CDBC2BCB3;
	Tue, 19 May 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202903;
	bh=1LeZ7aaDt0fOQkBu34KD+Jm+fXwQzL0U0/52fSh7Sao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s5T3NDjsHAXKjbWg6TX53DFy9GHC/e5EhfD5BcEv4/vgC9iSCc0iMhXnhPAaZJb/p
	 F4asnog+qvcLx2Zl1LEL6lKTfYe5y5drnmfxws15hC9nzeVhFEp9yHw2MkUZhlCO+8
	 a2yj6+xs0qOCn6XrhIgE9/CVkLHlhW57SX5iF/ftdMk8fiyD+KSJMY/Tw1imUVtYIZ
	 4KvnHIvnwmYFGTKhpbARrtfISDzgBWOeWP3RgmS+CV/VJdvpQsanYj3LrbJK1WX8GS
	 Jt0wrce5uHsMHFltVbgwuZ7QdiTfQfY/z6nNc6WAVtXawtLWMKCS9fX8LlyJ0roeJX
	 NPRKnqIjw4vtw==
Date: Tue, 19 May 2026 16:01:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Lant <joshualant@gmail.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, arpit1.kumar@samsung.com
Subject: Re: [RFC QEMU PATCH 03/10] cxl-type3: Properly unmap the
 memory-backend on device exit
Message-ID: <20260519160136.4115234b@jic23-huawei>
In-Reply-To: <20260429135717.3048713-4-joshualant@gmail.com>
References: <20260429135717.3048713-1-joshualant@gmail.com>
	<20260429135717.3048713-4-joshualant@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 14:48:37 +0100
Joshua Lant <joshualant@gmail.com> wrote:

> Currently the backend remains mapped, meaning that if the device owning
> the backend is hot-removed, it cannot be readded in the same QEMU
> instance.
> 
> Signed-off-by: Joshua Lant <joshualant@gmail.com>

Gah.  That sounds like a fix we should have in place today.

Can you send it as a separate patch with an appropriate
Fixes tag.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 68cd04b7d9..414c776028 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1072,12 +1072,15 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_destroy_cci(&ct3d->cci);
>      if (ct3d->dc.host_dc) {
>          cxl_destroy_dc_regions(ct3d);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, false);
>          address_space_destroy(&ct3d->dc.host_dc_as);
>      }
>      if (ct3d->hostpmem) {
> +        host_memory_backend_set_mapped(ct3d->hostpmem, false);
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
>      if (ct3d->hostvmem) {
> +        host_memory_backend_set_mapped(ct3d->hostvmem, false);
>          address_space_destroy(&ct3d->hostvmem_as);
>      }
>  }

