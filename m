Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5743C058
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494763; cv=none; b=Y4Tiyfdvt/hy3v2seEd91jDY+qAKeta/UVC8Ojqq2pT+EsyeCh5j4ePN7Vwz1Lw21hueSRJri1sTXPy07xO6RZFRRvAerqkCsIXeKTh1NdNkAhiJD39uBpHZEr3zn9OnH+VXpPPmUZVXK5k4V9CO9mcnjuM1yYFlA1GY8JvYXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494763; c=relaxed/simple;
	bh=e37wfpgbSCQE0mk69Y90W9JsX4G1tcdJSU+sDiJaYcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijL1ziDTLf+51XuwH3q5q6RH4+0mFWXI4lt5Vi0zQVwkkfT/5A8vwU4c99Ij86Fhon5s6DUKI4C2BzPzP1YF5YsIvfqpK63dZ39fv7MS4yvUkaCMf4bPEziudGYmT5dpUYyHhd5iFN3oK1nq7Gzh5/IKlvRpwM3fgS5G8OOkVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlVCiFBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlVCiFBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F14E1F000FF;
	Tue, 15 Sep 2026 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494762;
	bh=uodPxlgBecGq4pzVFqjxaJw1KTwHptSdfwPzXkSyiuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YlVCiFBaRvrGblGKhXWX0PxF5kcleH4rh9Y0lxfn0a0Mz7zGL4jdPdqKnZ0WFSk9N
	 7aPkCOAmh6DKccghtpgJEGfw+hH3HObZmGsryJmRpX+fQpWP8hbk7zdqlctelNeoue
	 o4durAKKYs3rOPIOalli+DFCv1i/9EVpGIUY6t+L1Mt/ILbNqufHFuLXu0kg0ixQbv
	 mZQwOkYR/mgqF+uYd8qyjbT2MZ01AyCniFWZnu3kuKj/VQMGAaLjYC9ZPNMgcmi1A+
	 jwM16nUQmJsLz2b7kyKxlSYugeES1y7cWm+ezjIO7Ktv+HBywktaZ/Z9SVEggNokv9
	 saR39xa7TzoYQ==
Date: Tue, 15 Sep 2026 18:52:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 3/6] hw/riscv/virt: Advertise the CXL host bridge to
 firmware via extra-pci-roots
Message-ID: <20260915185239.2c79393a@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-4-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
	<20260907093735.2753-4-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 17:37:30 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> The pxb-cxl expander bridge presents as a class 0x0600 host bridge with
> a type-0 header, so EDK2's PciBusDxe never recurses into it and never
> assigns the CXL root port a memory window or bus numbers.  As a result
> build_crs() produces an empty _CRS for the ACPI0016 host bridge and the
> CXL devices behind it are not enumerated by the OS.
> 
> Advertise the pxb-cxl expander root buses to firmware via the
> etc/extra-pci-roots fw_cfg file, the same way arm/virt and x86 do, by
> calling pci_bus_add_fw_cfg_extra_pci_roots() from virt_machine_done().
> EDK2's PciBusDxe then enumerates behind the CXL host bridge and assigns
> the root-port window and bus numbers.  The ACPI tables are rebuilt when
> the guest reads them (after that firmware enumeration), so build_crs()
> then emits a correct _CRS for the ACPI0016 host bridge.
> 
> The call is made unconditionally, in line with arm/virt, pc and hppa,
> so plain pxb-pcie expander bridges, which likewise depend on
> etc/extra-pci-roots, are advertised as well; the generator simply
> returns nothing when there is no expander root bus.
> 
> This approach also scales to multiple pxb-cxl host bridges (each gets
> its own window from the shared aperture) and lets firmware size the
> window to what is actually behind the bridge, rather than reserving a
> fixed carve-out.
> 
> Verified by booting an RVA22 guest: the CXL root port and Type3 device
> enumerate, and 'cxl enable-memdev' / 'cxl create-region' /
> 'daxctl online-memory' bring the CXL memory online as system RAM.
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Aligns with other arch, so makes sense.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
