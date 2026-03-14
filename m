Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED2A2E612E;
	Sat, 14 Mar 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773501300; cv=none; b=iYIBGMv3E0eAYufq5QZy27gKI7jijThG+i9pGta7Yfpb+LewWGFlANPDyDtlTsQ+VIuoAm8/xDsYY0LSKRXDNV0omrJqamlIhwjIvx3wYzek1n45gQsl37tUlH68EfS6HgHZSTEz5JYQg/ir8un2aBZdj9GfcRqsbTmrsVwNgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773501300; c=relaxed/simple;
	bh=vyUg2/POnxc9gt4Z43TtexU28mIRAXvCZ0AMbt8RNNQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Ci8DjTkG/DfX8LZUBC5uoj6mbfISeh6IOO7NX4fQbx73aa1RuuL5EoM2sjtE9CrsVyf1nvKTbe8dL8ENKz0o24ZbZdiXmtySiEp6CAPdJJEYdGfyiTAGU4ouucDbqzfg0RAtktw4Cq46oAO7izUsk5+PzFT9CVEv2v+6POCoecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uujOW959; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uujOW959"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741D3C116C6;
	Sat, 14 Mar 2026 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773501300;
	bh=vyUg2/POnxc9gt4Z43TtexU28mIRAXvCZ0AMbt8RNNQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uujOW9593bhwmjesTAM7VYyHNRAO3JKuJZqUX6Qdggi5K67XvZTsheY27CVHfdCYr
	 cHVbOFflajxnF2Yn+onZDi05zzL12Y61GkaHHHQVEuPygTKjC80wjIQEh1hnWXAMh7
	 y7teMXhd1mXUQ1TPIAWRnVHSnEoLzKkRUzCsD9gTpEe+XSDLmMyA+kWI0G4dJicPem
	 8ayp0iKaiJg/sfaDyyxIFBWeKqonkNbM1Pel0GcIc5cEH7dru7uH3GIjyPz6FBO5xa
	 uMvA1SgQRfEgPE7ccpqFYm1n5cJgr+LEl8vvS+td9xLnADGRq3oiLJyVjzeHtRiwL4
	 Z4vUppP3dMGaw==
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 14 Mar 2026 16:14:55 +0100
Message-Id: <DH2LQNQ1C0AE.KF8FK4JLBT0J@kernel.org>
Subject: Re: [PATCH 1/7] driver core: Add conditional guard support for
 device_lock()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Davidlohr Bueso" <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "Dave Jiang"
 <dave.jiang@intel.com>, "Alison Schofield" <alison.schofield@intel.com>,
 "Vishal Verma" <vishal.l.verma@intel.com>, "Ira Weiny"
 <ira.weiny@intel.com>, "Dan Williams" <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Ben Cheatham" <benjamin.cheatham@amd.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
To: "Li Ming" <ming.li@zohomail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com> <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-1-94fe919a0b87@zohomail.com>

On Tue Mar 10, 2026 at 4:57 PM CET, Li Ming wrote:
> Introduce conditional guard version of device_lock() for scenarios that
> require conditional device lock holding.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Applied to driver-core-next, thanks!

As dicussed, here's the signed tag:

https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
/tag/?h=3Ddevice_lock_cond_guard-7.1-rc1

Thanks,
Danilo
