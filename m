Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795611478;
	b=yXDGn1ryHjzExm/VbGDoxpm8KTlwEW22XjNsgU77bZqIOlvp6HkhsImX+BBcJDNjOACo
	 uGWR7gwRsjBzkKGlkm6Jha2uAIZX2AqtVu2SiuW/AYKpcKvb0vVi8svFqhzCupwP0r+fe
	 WAX2nx6BP+JwwiGrzDI88hhoBOw92M7Ll4EM+VLiU+hcLFnkFYUJFMsw2tad2YyMnFeEF
	 5d0Z8SsUw0pBcln0g/6PqhqB9YmGcI5zPjAOMjHQtPmJaIJw4vO/hE0xayvkHuMVRMi7u
	 PXKTZqzmUrmrMNqEcclVQkBIzFVewsFGrPNi3GzSPqZum+ciShBvHmlA+TOFJzDtF9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795611478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CkhgNAPN8vMVElrFRD9LK5ArtwIDN2VcTS60zUwfxoU=;
	b=Fk2HgywB3djD4nLw4D6HdiD72qWoQkB3XC0ihx1i9QIERcZT604PsLwbvSp8mxVi5Lee
	 GjLAl8IkyNDuLroHf53IimfFwJrUOOE0TwdlNOJPrrnZ6zI9ukJozvWAflg8KfUZu4g18
	 eMJYc4RspoKpZMhFXrg25uoBhoiGiAWR0M6R9T18ni9ixyEqxR1DB43IMFd/izTac/IWm
	 hSUd1xHPjCQYGPNumSjmTcwRS2l+oPpCQWV6asl/2xZ03C/MATCR8/hz/0MMsoca1AisU
	 1EvW+KEGZMMHW6vDo6MAHThxAJ7Er/ePscVCbXYmjltEPXtA9f6g9TXkE7G74RJUcag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YROFDrfX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD89606A323
	for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YROFDrfX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E7D1F000CA;
	Wed, 25 Nov 2026 12:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795611477;
	bh=CkhgNAPN8vMVElrFRD9LK5ArtwIDN2VcTS60zUwfxoU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=YROFDrfX4Aqdr2WsZcTNeauO/02YwZFDSfmHoHHycA6AEYSlDRqlII5Ba4r0L9qV8
	 aJ4Wswq4/8So/kdxLI5LYOT3twBg13OBtkhPe9hdGivfzjpRNtsGaepoGNZdwUWuXR
	 BMxWTSBCX/wOZIfWOYwQIKXWlFVpb3S5MmeRRmI+JFgiI4kAZu/Mb4j9XC8aucOxHm
	 Dz7bHswBSSNZN98s0aMHsX/ph31RCsLczlIaYKfztw7ipvJwop2XKbB7Jf49l5n5pz
	 P3sQlb7a4oLOZ0aHzOUr9vK5HpqG0iIvB+zzNvWKe1M0I6BkXMMJwTSMViDX8uA4dl
	 SIradDy4e/azw==
Message-ID: <sashiko-outbox-233405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] cxl/memdev: Add firmware_activate to activate
 firmware without a reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Unsung Lee" <unsung0317@gmail.com>, linux-cxl@vger.kernel.org
In-Reply-To: <20261125124358.3583223-4-unsung0317@gmail.com>
References: <20261125124358.3583223-1-unsung0317@gmail.com>
 <20261125124358.3583223-4-unsung0317@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 12:57:56 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] cxl/memdev: stale CXL_FW_ACTIVATING bit in
  cxl_mem_activate_fw_online()
- [Medium] cxl/memdev: activating_slot overwrite in
  cxl_mem_activate_fw_online()
--

commit 19d55015d9b6225e3059d6173d8fb4365535c893
Author: Unsung Lee <unsung0317@gmail.com>

cxl/memdev: Add firmware_activate to activate firmware without a reset

This commit adds a write-only firmware_activate sysfs attribute to activate
a firmware slot online when the device is not decoding memory, while blocki=
ng
decoder commits, firmware uploads, and sanitization until activation
completes.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index cdbebd12258b9..cc9ff0dd9cd8a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
[ ... ]
> @@ -966,13 +1010,136 @@ static int cxl_mem_activate_fw(struct cxl_memdev_=
state *mds, int slot)
>  		.poll_count =3D 30,
>  	};
> =20
> -	/* Only offline activation supported for now */
> -	activate.action =3D CXL_FW_ACTIVATE_OFFLINE;
> +	activate.action =3D action;
>  	activate.slot =3D slot;
> =20
>  	return cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
>  }
> =20
> +/*
> + * cxl_mem_activate_fw_online - Activate a FW slot without a reset
> + *
> + * How long a device holds CXL.mem requests while it switches to the new
> + * firmware is not known here, and a stall the platform does not tolerate
> + * would take the memory down. Like sanitize, only proceed when the devi=
ce
> + * is not decoding any HPA range, i.e. no endpoint decoder is committed,
> + * and set CXL_FW_ACTIVATING under cxl_rwsem.region so that none can be
> + * committed until the command has completed. After a timeout the device
> + * may still be activating: keep CXL_FW_ACTIVATING until Get FW Info
> + * reports the slot as running or an activation succeeds. A device that
> + * keeps its old firmware then refuses regions until cxl_pci is bound
> + * again.
> + *
> + * Decoders of other hosts sharing the device are not visible here.
> + */
> +static int cxl_mem_activate_fw_online(struct cxl_memdev_state *mds,
> +				      unsigned int slot)
> +{
> +	struct cxl_mailbox *cxl_mbox =3D &mds->cxlds.cxl_mbox;
> +	struct cxl_memdev *cxlmd =3D mds->cxlds.cxlmd;
> +	int rc, info_rc;
> +
> +	rc =3D cxl_mem_get_fw_info(mds);
> +	if (rc)
> +		return rc;
> +
> +	/* An activation that timed out has completed (cur_slot is never 0) */
> +	if (mds->fw.activating_slot =3D=3D mds->fw.cur_slot) {
> +		mds->fw.activating_slot =3D 0;
> +		clear_bit(CXL_FW_ACTIVATING, mds->fw.state);
> +	}

[Severity: Medium]
What happens if an online activation of one slot times out (leaving
mds->fw.activating_slot set) and a subsequent write to firmware_activate
requests a different slot before the first activation finishes?

cxl_mem_activate_fw_online() proceeds to issue an online Activate FW
command for the new slot while the earlier activation may still be running.
If the second command also times out, mds->fw.activating_slot =3D slot
overwrites the original slot number; once the device finishes switching to
the first slot, mds->fw.cur_slot will not match the overwritten
mds->fw.activating_slot, leaving CXL_FW_ACTIVATING set and blocking region
commits, firmware uploads, and sanitization.

> +
> +	if (!(mds->fw.activation_cap &
> +	      CXL_FW_INFO_ACTIVATION_CAP_HAS_LIVE_ACTIVATE))
> +		return -EOPNOTSUPP;
> +
> +	if (!slot || slot > mds->fw.num_slots || slot =3D=3D mds->fw.cur_slot)
> +		return -EINVAL;
> +
> +	/*
> +	 * A different slot set up for activation on the next cold reset
> +	 * would silently replace this firmware at that reset.
> +	 */
> +	if (mds->fw.pending_slot && mds->fw.pending_slot !=3D slot &&
> +	    mds->fw.pending_slot !=3D mds->fw.cur_slot) {
> +		dev_err(&cxlmd->dev,
> +			"slot %d is pending activation on reset, not activating slot %u\n",
> +			mds->fw.pending_slot, slot);
> +		return -EBUSY;
> +	}
> +
> +	/*
> +	 * synchronize with cxl_mem_probe(), sanitize and decoder write
> +	 * operations
> +	 */
> +	guard(device)(&cxlmd->dev);
> +
> +	/* A running sanitize owns the device until it completes */
> +	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
> +		if (mds->security.sanitize_active)
> +			return -EBUSY;
> +	}
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		/* Without a bound endpoint the device may still be mapped */
> +		if (!cxlmd->dev.driver ||
> +		    cxl_num_decoders_committed(cxlmd->endpoint)) {
> +			dev_err(&cxlmd->dev,
> +				"device is decoding memory, not activating firmware online\n");
> +			return -EBUSY;
> +		}
> +		set_bit(CXL_FW_ACTIVATING, mds->fw.state);
> +	}
> +
> +	rc =3D cxl_mem_activate_fw(mds, slot, CXL_FW_ACTIVATE_ONLINE);
> +	if (rc =3D=3D -ETIMEDOUT) {
> +		mds->fw.activating_slot =3D slot;
> +		dev_warn(&cxlmd->dev,
> +			 "slot %u may still be activating, refusing regions on this device\n",
> +			 slot);
> +	} else if (!rc || !mds->fw.activating_slot) {
> +		/*
> +		 * After a timeout only a success shows that the device is
> +		 * done. Any error may come while it is still busy with the
> +		 * activation that timed out, so the mark stays.
> +		 */
> +		mds->fw.activating_slot =3D 0;
> +		clear_bit(CXL_FW_ACTIVATING, mds->fw.state);
> +	}
> +
> +	/* Report the slot the device runs now, also after a failure */
> +	info_rc =3D cxl_mem_get_fw_info(mds);
> +	if (info_rc)
> +		dev_warn(&cxlmd->dev, "cannot read FW slot state: %d\n",
> +			 info_rc);

[Severity: Medium]
Should the post-command cxl_mem_get_fw_info() call also clear
mds->fw.activating_slot and CXL_FW_ACTIVATING when
mds->fw.activating_slot =3D=3D mds->fw.cur_slot?

If cxl_mem_activate_fw() times out (or fails while a previous timed-out
activation was finishing) and the activation completes right before this
second cxl_mem_get_fw_info() call, mds->fw.cur_slot is updated to the new
slot, but CXL_FW_ACTIVATING remains set and locks out region commits,
firmware uploads, and sanitization until another write to
firmware_activate. Re-attempting firmware_activate on that same slot will
also see slot =3D=3D mds->fw.cur_slot and fail with -EINVAL after clearing =
the
bit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125124358.3583=
223-1-unsung0317@gmail.com?part=3D3
