Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813144;
	b=tGhW8ed16uL0yb5QAOgBc97ty5FuZ+a1/1ok94/eZdVDUS91okDYseP3MNVUYwO3doze
	 R37Nl/Pg+MVLjHlhRHX4eVQWnwEPQqj+sjtYnY86sgf/xBlko6fZOfceg2uAtH9y2OnA3
	 P0aObITH8cWjNX4ibYezeG1oq7zZBxif87GwizeCI4oVaF44N+R36HZiIjTKJz17b3/lx
	 zi+86eVxAXVBzYmqXSRk8urewM7TJRNvMhd1ecii5hqx5UOx1u9cAb9s4SNVBnTK6b51F
	 wbZ7ryIK/s2TCm186cNQvoIJYkk8CC7uBiavI6/MdIly9zDPMzXaceQSn0RE8fMBRPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813144;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KvcV0c4jRWUZ56qd0nf0GVpOhs3x5p+gMgincRqh3Ic=;
	b=HP6avrX5mrSbtumaeESe0Xxe9YfasbpXt+IqIwjfhuro6yH5AP64/qFnNKoq9UkYrXh+
	 nBqWoOF3RjFC/6porCPizErbu5Jzgtll20IUB0HffBhKWhuApeBb+lpEqzv9lCfkYu18a
	 6e5TrAfiU8GR+41qoYk1saHxI43+aQza4F4QKrcdtgNQMK72UOdCpYtqxyAillwIJp5zs
	 nWRLd9pmukO2Eb67xQgYmy5ZsiPrLhfMMpKpXBPJZlffZwFbAXmVcfPtAUAZYNPDm8uFT
	 jhPZd2G98i6ZGNj0P6avNLMY9TjvusQo954jgXTgCEFcldzjJXFyWUOzdDlwTQHnrtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S0l21P3y;
	arc=none smtp.remote-ip=95.215.58.140
Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF5606A31B
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AFF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=S0l21P3y
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KvcV0c4jRWUZ56qd0nf0GVpOhs3x5p+gMgincRqh3Ic=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813141; v=1; x=1794417941;
 b=S0l21P3yf/EePM9E9LVhImMS+NLGodZraKUntXJ5bfrGOm+j8hDq8LYrITNGVc5POFBrwkgL
 II7V0CZCApoELbfDW2dddTvPJiZOjcSHmRPgmfzRO9zz1+vB68taSpBAlPZhh8e3+gMdQ6MGwY6
 CFsrYE3xjvLHmwlM+ztltrHI=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4064cf3a45f60569;
	Wed, 04 Nov 2026 17:25:40 +0000
X-Mizu-Trace-ID: 4064cf3a45f60569
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: shrihari.s@samsung.com
Cc: jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org,
	anisa.su887@gmail.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	arun.george@samsung.com,
	cpgs@samsung.com,
	dave@stgolabs.net,
	dongjoo.seo1@samsung.com,
	gost.dev@samsung.com,
	s.neeraj@samsung.com,
	vikash.k5@samsung.com,
	anisa.su@samsung.com,
	junjie.cao@linux.dev
Subject: Re: [PATCH qemu v1 4/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC) capability
Date: Wed,  4 Nov 2026 11:25:25 -0600
Message-ID: <20261104172527.2172366-2-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <603443293.161793792284076.JavaMail.epsvc@epcpadp2new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com> <603443293.161793792284076.JavaMail.epsvc@epcpadp2new>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

The protocol-selection checks now reject the bad writes from my previous
review. The TC/VC map defaults need another change, though.

On 3c99db7705c1 plus this series, Resource Control sets 1 and 2 read
zero at cold boot and after a system reset on the tested CXL root,
upstream and downstream ports and Type-3 devices. PCIe 6.2 section
7.9.29.7 requires the TC/VC Map default to match Table 2-46:
TC3 to VC3 and TC4 to VC4.

Software that keeps the default map and only selects UIO and sets VC
Enable writes 0x80000200, which reads back 0x200. Restoring defaults
of 0x08 and 0x10 makes that read-modify-write produce 0x80000208 and
0x80000210; both then retain VC Enable.

Could init and reset restore those map bits while leaving VC Enable
clear?

Many thanks,
Junjie
