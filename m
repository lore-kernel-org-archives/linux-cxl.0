Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73F1547C0;
	Tue, 10 Mar 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170278; cv=none; b=k+2G6tagN8jM75jicTpt/G0a83kdYVI35Xheh42XpT1CSnlgerNjKa3XviPaeyYm4WBm5wIfsHxM5rLDDq9rmjUGozC5Tfu79q3UuiOdaABtS2Z95I0lQKGvsf5gk/iYtBLTJiODfwVmZRHatJzPrbfldzV+GbzaQiuOk0qKE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170278; c=relaxed/simple;
	bh=jJPESyvb74xZStLyv3mxSGKa5bj8k344JLFmeWiE3Bg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=CI6KMnqS7kRTiAJBS6dnF1+oQvqBoC/AfeOHeAtN9pZvoAOxv85NS5Hm97ExvL+L0v5mtu2SUHpsKFsJIINOvx91ao3sQJTaOq+Niw8WbAqF4wf7KHfAtrMl7MBjdwDauL0fjyAdFQz3zFTz1qxpnKQxcT+npkXABgu1UMuAwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOKRxH4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOKRxH4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E76AC19423;
	Tue, 10 Mar 2026 19:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773170278;
	bh=jJPESyvb74xZStLyv3mxSGKa5bj8k344JLFmeWiE3Bg=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=eOKRxH4wh1uanxkS47ma4y6FELv6Y/s4vdqFxMhwHSwAuvLW/DSB7JaPvt2GPkBgd
	 02i4PXEA/8NvzX/vfYJCCUCTvGWh0Biujgs1dUZM1bhSRKVOrJ59dC7TIodY6k7QXf
	 H3cKUO6C+xM22XqxiMmCzzM+0/SiPWmDn/8ZcHKEEH/lYFI8p13NDLpQIzlmbOWk/o
	 gPVdsYEeDA3WDiY9tWviDxo21rDMjWc3YvgCVNcjC5FFKj6a3y7e+3TIlXALrKxzHG
	 1tmG6B0Uc7Zl2tVMBCjNOWjzEVz2/8kon0/sP+Bl9gEN8mTrSVMD6gEMByxwLutEpN
	 zvlMflQR1xJoQ==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 20:17:53 +0100
Message-Id: <DGZCEIBES82T.27Z7GZ605OVB@kernel.org>
Cc: "Dave Jiang" <dave.jiang@intel.com>, "Li Ming" <ming.li@zohomail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "Alison Schofield"
 <alison.schofield@intel.com>, "Vishal Verma" <vishal.l.verma@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Ben Cheatham" <benjamin.cheatham@amd.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
To: "Dan Williams" <dan.j.williams@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com> <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com> <127f99e8-f673-4cec-a573-be2257134f59@intel.com> <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org> <43577d8d-f95a-4964-abe5-3e0b7155e99a@intel.com> <69b0654e4ffd1_2132100ce@dwillia2-mobl4.notmuch>
In-Reply-To: <69b0654e4ffd1_2132100ce@dwillia2-mobl4.notmuch>

On Tue Mar 10, 2026 at 7:39 PM CET, Dan Williams wrote:
> Dave Jiang wrote:
> [..]
>> >>> diff --git a/include/linux/device.h b/include/linux/device.h
>> >>> index 0be95294b6e6..4fafee80524b 100644
>> >>> --- a/include/linux/device.h
>> >>> +++ b/include/linux/device.h
>> >>> @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *=
dev)
>> >>>  }
>> >>> =20
>> >>>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unloc=
k(_T))
>> >>> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RE=
T =3D=3D 0)
>> >>
>> >> Can you please just squash this small change to the same patch that i=
s using it? Thanks!
>> >=20
>> > Why? It is a single logical change and hence should be a separate patc=
h, no?
>>=20
>> For some reason I missed it's in linux/device.h. So sure ok. But
>> typically I would like to see the usage if it's in the same
>> sub-system.
>
> I generally expect the same as well.
>
> ...however, when we get into multiple in flight patch sets wanting the
> same API [1] it would be nice to have a stable commit id to share, Greg?
>
> [1]: TEE I/O enabling also has a use case, and introduced the helper
> with the "first" user.
> http://lore.kernel.org/20260303000207.1836586-7-dan.j.williams@intel.com

This patch has neither Rafael, me nor the driver-core mailing list Cc'd and
buries this change in a patch named "PCI/TSM: Add Device Security (TVM Gues=
t)
LOCK operation support", which makes pretty it hard to catch.

Please submit such changes as a separate patch and send it to all maintaine=
rs
and the corresponding mailing list such that people have a chance to take n=
ote
of it.

As for sharing the commit throughout multiple trees, I can provide a signed=
 tag
similar to [1] once Greg and Rafael had a chance to take a look at this pat=
ch as
well.

You may also want to sort out authorship / tags with Li.

Thanks,
Danilo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/tag/?h=3Dplatform_device_info_swnode-7.1-rc1
