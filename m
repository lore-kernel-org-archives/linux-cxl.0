Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A593F0A9E
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495018; cv=none; b=qyYM6Ha2H++LqdBhM3/+TZ1VD05F9exeG/fX7EaeDqtHrcxWZjHGHogKUjbScjKw0XhsetvlNQckykDzFO9yvpyQDxmsQH2zulv+vyZ36/vo6l/j6HVnWCU65g4HPLbtllRXsH8Tp+iylaOu9SzO7KZtbV+WYOA+HvtHMuB29Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495018; c=relaxed/simple;
	bh=h+X3Iokw+O0jUelLZmQg5POWUnm/3BclkK93D5XZ08Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6TN8jNsUCFFmLpF2bH1p5VUgHiLNri81lekdjdurhvVQ6SENeYWo1efB5Vqy5ZcsAypJw7LiNKo8U54cwh0WBpdJdRBf/y3jvqlwt0FT0kKjTEdhcPrVyhEAyoZgL0dj9gIL207ai85nqSeTqUI5cSgYyHXDidNLViPBv7/FvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6AEoLYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6AEoLYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC321F000FF;
	Tue, 15 Sep 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789495016;
	bh=XseWBq8izn0Nrmc0zn5blFXPCwaM4UJNp8e2A5vqhqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B6AEoLYwWfv/YjRFBn2qURpPFo3w3W+OStjkg9O1CWS1UA/0IQ+pT+wFdsVv0k/6T
	 FQZ5SPAseZhnW3ZWVbtjKeHnIWOffVIjRQ2/nGv9cavrIaC/zUly45ixakynQuWq2P
	 xHq/vWRr6bIw/s2Pp+wRnAS+u31Aawq/ku69hCJ8lY4cCBapotlPP0JUZrqncA8pGk
	 v9EOhqV5PGu2XzS/kHMnHIGT7yaJg05tDyvE+l59f2USnNJPo0YsXiR1G3eEVKuhc/
	 J3HVr/7dMU2uccy29uQLppCZVznlxih2iCLFJCpTCM1TIOoOadMqImkiB5iSKTcZ7M
	 y7VTP2P/qwhgQ==
Date: Tue, 15 Sep 2026 18:56:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 6/6] tests/qtest: Update RISC-V CXL ACPI golden
 master binaries
Message-ID: <20260915185650.272825f6@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-7-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
	<20260907093735.2753-7-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 17:37:33 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Populate the DSDT.cxl and CEDT.cxl golden master binaries for the
> RISC-V CXL bios-tables test and empty
> bios-tables-test-allowed-diff.h, following the bios-tables-test update
> process.
> 
> The expected AML added by this series is:
> 
> DSDT.cxl:
>   Device (PC0C)        // ACPI0016 CXL host bridge (pxb-cxl, bus 0x0C)
>     Name (_CRS, ResourceTemplate () {
>         DWordMemory (... 0x40400000 .. 0x405FFFFF ...)   // 32-bit MMIO
>         QWordMemory (... 0x400100000 .. 0x40010FFFF ...) // 64-bit MMIO
>         WordBusNumber (... 0x000C .. 0x000D ...)
>     })
>     Method (_OSC, ...)   // PCI host bridge + CXL UUIDs
>   Device (CXLM)        // ACPI0017 CXL memory controller
>     Name (_HID, "ACPI0017")
>     Name (_DEP, Package () { \_SB.PC0C })
>     Method (_STA, ...) / Method (_DSM, ...)
> 
> CEDT.cxl:
>   CHBS : CXL Host Bridge Structure, Register base 0x800000000
>   CFMWS: CXL Fixed Memory Window, base 0x810000000, size 4G
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
