Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB6B3CD8B0;
	Tue, 10 Mar 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165967; cv=none; b=UeyIoDUh5jpG2q7/KbDwp9d5NrT4BgPsfDE7IJwwFsP7FJGS5aUV3LLA43NUY6n5qvKKHTQzypWLc9+K8IjVw/+mcfls+8XJqahLOQeDxoY61J+iaTGxCnHlE4PHEE2sZBFQs553wSJTuhj+K+Ayw2LUpnyUk99Q+akEnQtMa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165967; c=relaxed/simple;
	bh=grf7f8fyBlbjzzyHMXwiOtW5i2uX6cgXt50+x7jN2Ds=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=u98qwcseXaSSHArmfORnZXoeEEEKluMi7qTVrZzjnVu4hcV5Ec9C4bF5eqxPqidFcJjLZ1BtCc//Q4atP6gcqkBcPEhW00uQgbgQUGJSyKocKYFVFxcDsqksYzyw3I7nZ09bVvF0tGEFWcMmpUXV0rga0lC1huGLucu5jbwrIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM/0qk4t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM/0qk4t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D18CC19423;
	Tue, 10 Mar 2026 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165967;
	bh=grf7f8fyBlbjzzyHMXwiOtW5i2uX6cgXt50+x7jN2Ds=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=gM/0qk4t6ISaYInitlaGA/s0+oWI6QAea2NmJQhDSw3iACw39K/WhoyWAEv6wTEoA
	 OINRiiAXeR7ZLWws2T/P8qVX84Sj2+gyZfBzN1Y4FEtNIc1onDjEVx+1wZbJrQCTdV
	 Fw6b0l/F8E1lvQCuEtMVD2Xh+wsSwAoHnbCi7+GRFisJQqnweJ2oOEyW3ZpPINKd1O
	 iLSq5Qz3q+I1xHYLP7uDJkb/9wJH7YYjo6uPEWbzX6x5M5nI1LFMw93jNKPot5X3z8
	 lTorB1GRGLpkGQcYbP31vM6tQkimuCZucacV3lig8QMxYzKSMvl1x70bwdwgpM1Vqk
	 3KtC7H/7+1wUQ==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 19:06:02 +0100
Message-Id: <DGZAVHW9AW34.3UKJ8WV6QR8XI@kernel.org>
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Cc: "Li Ming" <ming.li@zohomail.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Davidlohr Bueso" <dave@stgolabs.net>, "Jonathan Cameron"
 <jonathan.cameron@huawei.com>, "Alison Schofield"
 <alison.schofield@intel.com>, "Vishal Verma" <vishal.l.verma@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Dan Williams"
 <dan.j.williams@intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
To: "Dave Jiang" <dave.jiang@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com> <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com> <127f99e8-f673-4cec-a573-be2257134f59@intel.com>
In-Reply-To: <127f99e8-f673-4cec-a573-be2257134f59@intel.com>

On Tue Mar 10, 2026 at 6:45 PM CET, Dave Jiang wrote:
> On 3/10/26 8:57 AM, Li Ming wrote:
>> Introduce conditional guard version of device_lock() for scenarios that
>> require conditional device lock holding.
>>=20
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> ---
>>  include/linux/device.h | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index 0be95294b6e6..4fafee80524b 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -911,6 +911,7 @@ static inline void device_unlock(struct device *dev)
>>  }
>> =20
>>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T=
))
>> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET =
=3D=3D 0)
>
> Can you please just squash this small change to the same patch that is us=
ing it? Thanks!

Why? It is a single logical change and hence should be a separate patch, no=
?

We even tell contributors in the documentation [1] that adding new APIs and
using them should be separate patches.

Additionally, in this case it affects another subsystem, so it also makes s=
ense
in terms of making the change obvious to the maintainers of the other subsy=
stem.

[1] https://docs.kernel.org/process/submitting-patches.html#separate-your-c=
hanges
