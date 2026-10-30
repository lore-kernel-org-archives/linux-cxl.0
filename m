Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364283;
	b=RLAx17JZwAXHlL68MyzIFu8J/taEjXZYyRXHUPcaMwG5xIoKLU/Y/Uc0cT2y+MGH5M5i
	 rn1kWH2fkxzQIWwdt1R6ZSWJUFMhrsGwq4fby9E08xhoVIQMK0TepjwvCTnhNQCpt5MQ7
	 /WA9uc/07YxTbjtpNFZK0bOZi7oiVZwlzYHsas6F+60oDt0kpEWLdz/n7dWJ4sTG2sMQb
	 82AN2GQfpt3wBYCh5U9vZ7oJnw/r3hJ2GGcweZsGZ3cvmk8omNbyD86eORqjrKzqxoDAt
	 TFMmFzQHRCiitxXm/3usSyikyW2lm/lbeQ5l7qKBeWNoOY1VckzH6I5UFPHfNxaR/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364283;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TEVH8SHcLytPnkygqFo+kY1zSEY44saM1DUrM9+em9U=;
	b=1rGc2XTo6xIlz1Drc8AJVcghRrK7kGJ6Oo8RSRJvgCOVBdfgrngxQpTiy1EoGgV51fNQ
	 MRGtEC7GSw4W/WfZSE+a8IuVSvAX5D/MWx3/mS/E4RKB7TWkc8qFFwfgZWIWvifUsr5Ga
	 ZiriRWn4WzpUmtvr2W1j6xmze7DOX2R6FLfAwRdUIGK2KbKkRpS1iu4slcw+Q0DfzbXN/
	 NyX+Ohr+VHV6c66k6WzqV/DBnANb/bUahugKHndcS07fDyR4Vo6EzZ2tfIqAlEV7L+YgP
	 /wp2ifcPiIT98A3LYxclw2n3hb/r2+RiFQsd6RR8rQ+c8J2iWkNUINIu2/3ZVsXpT7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bF3vlsBY;
	arc=none smtp.remote-ip=91.218.175.12
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FB606A31A
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 12:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E90FB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bF3vlsBY
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QtRt0ves/wBA9PlBFoIyVL02XOI83JkkfiRXPN+Jr1Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793364280; v=1; x=1793969080;
 b=bF3vlsBYShxzSfNICMVK7D3iEdA0hA+Pn3fFxnUMD4y8XrpXxyzENFE5M/LSFcxEBTQrM48i
 dAARL8/LrR0e4AgLisyFF511jraGSs+3O6rAgBXnfxl7+c7+a9iZxKssHmlrstkwiHsiThRD+Ue
 Qp8Fj7t6PP5tH80YJ09nMQ8o=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c66046834214a38;
	Fri, 30 Oct 2026 12:44:39 +0000
X-Mizu-Trace-ID: 5c66046834214a38
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org,
	jic23@kernel.org,
	philmd@oss.qualcomm.com,
	linux-cxl@vger.kernel.org,
	junjie.cao@linux.dev
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and convert to three-phase
Date: Fri, 30 Oct 2026 07:44:31 -0500
Message-ID: <20261030124431.1066454-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
References: <20260729144645.1552511-1-junjie.cao@intel.com> <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
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

Hi Michael,

On 30/10/26 14:35, Michael Tokarev wrote:
> This patch series has been Cc'ed to qemu-stable@.  It is interesting how
> it's been Cc'ed, and I think there's some error here.  From whole series,
> only patch 2 (destroy primary CCI before re-initialization on reset) is
> tagged for-stable.  Patch 1, which is a fix, is not tagged, and not Cc'ed
> to qemu-stable@ either.  The rest - patches 3-7 - has been Cc'ed to the
> qemu-stable mailing list, but are not tagged for-stable.

Thanks for pointing this out. Only patches 1 and 2 were intended
for stable; I copied qemu-stable@ on the whole series. I'll keep
the stable Cc limited to the relevant patches in future.

Patch 1 carries the tag both on the list and in 259b877eac, and you
already have it as 4a39c7d61e in 11.1.2.  So for 11.1.x patch 2 is
indeed the only one left.

> From this list, I'm only picking up patch 2, and only for 11.1.x series.
> The other active stable series, 10.0.x, - apparently it's not needed there.

Neither applies to 10.0 as-is since cxl_destroy_cci() only exists from
10.1, but the leak is there too: ct3d_reset() re-runs cxl_init_cci() on
all three CCIs, allocating a new timer each time.  I've just sent a
10.0 version, "[PATCH stable-10.0] hw/cxl: free the CCI background
timer on Type-3 reset and exit".

Thanks,
Junjie
