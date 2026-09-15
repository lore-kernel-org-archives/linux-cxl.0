Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6AB3D5C06
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494799; cv=none; b=IbBrQ/q/8kunaS6Ow8IY/9BVS/iysZc3kpPPqKcTZVEzYrs4qMp6LiBwk1l3jhe5NYUQHqwNqVFB9Nr+RH7NwEpFlFf7xL6M3WlM2pfN7kY9F5sDnBQVwo7vWH7s1fxFeOFgeqDfwBXuAZ3EMCfr+8TWWY7lbRmmcS5Fb7vS1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494799; c=relaxed/simple;
	bh=eoO0T5VH+uJuj+uvehPjVGuftHhBAR4zMzZ7VcA56Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DKC//RjqtFQwuNjzzMhan6EmKLohzve2wXXEr/JuOjHMv8+i4F9UpBvEqsY/7KpsvGB8Wes3uPKJXWDHjcnUfr6sM7jSzCWTv4pFqIieQ3eEe58ILHgpfQ0+AOTB+TV1DFEjA9aV29c0xOlQhPC2g5FDhKbEz3vwtbNAbBYv768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdhlOSlb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdhlOSlb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38E31F000FF;
	Tue, 15 Sep 2026 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494797;
	bh=EDg2lbS9FxueOTc0OmiHtUQtfNsIvgIeTNuEARoespI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CdhlOSlbpttVGy84O4uFXV4oqNG9WLZTkedirtWQhq/IGhK5rsW/OOoOlK3H7PbT/
	 iGkdJSxbjuMrlUxr6GUyUVG9k34URDKZ7KT81+QdLHlsHpk96d6Qfv27jBij2Rhwcn
	 bLJRgs9tDAjWT39A31I+TRpfSUGsFjrUSxbIwglwW+aq27PESlJKKBsNh+sjh33m29
	 xKSxgk5w+5W4sc8vwj/l0LOSg9mRkfUfyybGEQygoENeHO1Mfn5yLwhLkbofmkgCrC
	 15z6jidU/ZJRTtrDrdPKa6wplSGjUCO8N2aIk2/J9iMRyYlP8GqW6vLSHYJTbhGVz5
	 38I/aowXoYmhA==
Date: Tue, 15 Sep 2026 18:53:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 4/6] tests/qtest: Prepare golden files for the RISC-V
 CXL ACPI test
Message-ID: <20260915185312.3af64924@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-5-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
	<20260907093735.2753-5-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 17:37:31 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Add empty DSDT.cxl and CEDT.cxl golden files and list them in
> bios-tables-test-allowed-diff.h, in preparation for the RISC-V CXL
> bios-tables test added in the following patch.  The populated golden
> master binaries are committed separately in a final patch, following
> the bios-tables-test update process.
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
boilerplate but for completeness
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
