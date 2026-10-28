Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153763;
	b=wcI+SgahN5wXlAM0OvuchOcmfgfBIE1BaegGYaHZtfBuro9haspdu39p8I4oUJiCAXZq
	 2dqT1bz//iFljwsdQXkT4+BDUb6/pgred58KYko+uxfMlgT0hhe1t8EdOW2+tj/boNm1L
	 SeFEE5UD343jwCxXROqkgZRijLnYX4Dj5hnNewM760VGMJSMBWWMLX9BuCsxhANBZgV3s
	 q90mUXf9KcjlKsNSNfVCWW/ntrRMVChkJbj69YYSb+Ygf7NQ8JjOzMa0E5wlb4zO2fLL9
	 ngs/fAWnTdZ7WgE6N0I45A9zk7ruKSevKmhBrr4wBGjMQkEjSka0Ei3uP/gZ4+jorsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153763;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nhKBgpWBp6UT0ZLGjWyVq714r1vaHD7/A7/243Tlg8g=;
	b=v01o7GpsXd0JvdBjCFuUCTIlAxhDKHe3rnG4XgaS19yGJBYTUU/olXhP3HBfSNU4gFo4
	 UBFYNtAwxAQFdhAX7nxX7Mi3RxGJ/B0y6axz6PqNa7Fa6np8zYg0Ce5CPShiJgManU1Yz
	 iVM55+9JFWtyWvDntF2v78oSSn2zSuP2tU+c+/fRcNM36MoTthkboyrR7mQF5poSCDBnt
	 EFGtDmHUiAPFXMpmGyecIvSOmmRgrrG8EfJgf3dakNODIvHCJ/fJWIrEFBVv53nf/VR25
	 jYZNqzHyYqmFVzGIIesovz+XjVk5rJLDkNCG/22UuIXHCs8ncQ4b8OkLmYRJ/8Di0Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="hEVxZ/b1";
	arc=none smtp.remote-ip=95.215.58.55
Received: from mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED34606A321
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 02:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ED34606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hEVxZ/b1
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nhKBgpWBp6UT0ZLGjWyVq714r1vaHD7/A7/243Tlg8g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793153760; v=1; x=1793758560;
 b=hEVxZ/b1hi9Km3fdsq6DWZdjobTxcT3k63wUzAIP15RZSYNiL81XHhkCCwIxHYMB01KrWHLU
 lZ8IsSWwqnqmXdJy3b9Niexz23pxuuKuSb9Fvhk/mYQxN0jr7aM3FvJjy3rC6nRHJpccrMs11iC
 OjkZ8L8FgsDWObxkXz8qYWEw=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7889769fc7395345;
	Wed, 28 Oct 2026 02:16:00 +0000
X-Mizu-Trace-ID: 7889769fc7395345
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
	jic23@kernel.org,
	mst@redhat.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	junjie.cao@linux.dev,
	junjie.cao@intel.com
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Date: Tue, 27 Oct 2026 21:15:51 -0500
Message-ID: <20261028021551.498530-1-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
References: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Philippe,

On Tue, 27 Oct 2026 19:20:21 +0100, Philippe Mathieu-Daudé wrote:
> On 21/10/26 15:43, Junjie Cao wrote:
>> -R: Junjie Cao <junjie.cao@intel.com>
>
> Could you Ack from your other email?

Sorry, I've already completed my handover at Intel and no longer have
access to that mailbox.

If it helps, this aw99706 kernel driver patch from August is
DKIM-signed by intel.com and has linux.dev as author and SoB:
https://lore.kernel.org/all/20260804030255.1934470-2-junjie.cao@intel.com/raw
