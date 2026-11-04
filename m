Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.79
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813149;
	b=AtX0JyOOdJthiZmOg7UkxEeNAh+spC1NJyWs67Y5hRKVYTHgqqDSWIyZUzqArT1CbmLF
	 VmC8BW3pfvzCP1eRP8XONnyFk///reRP7efKPgqddh3GWcunmzyBt0y0ggLG8MKBmiB/u
	 u4tTwjc8MpZQDgk2sCvGtPRJfv36v20yZqbfsn3BSkokHnhWLET/nD9Rd8EImBZ9Ta2D4
	 dj1zvDWBhMj7MMYfC4XoGpnI3yi3vKEZyiB+X+2XI0/9W0lO5uC3zWfI9Mw/HHK2acexI
	 u5zR5b5D2M8+Ie4HRZQ+nLnp+6Mm8fv+a01mSpvwLUgJlpiCz+/sJYfFDx1fDrfY7Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813149;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MxR3c48AzklxPRyTJpjhZAtl2/Qg2f+G50G0qs7v1Wg=;
	b=m8iY15dK2pbAF5aJym3Qio2MrQWx3qw/CWvzK9vBEZ3t+oQm2wX2BiS8oTRFhOJeUCSy
	 iKiH5B79j2GJmqS5iYmz/JucEUWlcJ2wcSnNufftDZ7FRaMmq0/7+uzAUgOE2cXejP0mA
	 1/2rnB0bz/S8sp5d6guiWsWFPkCGuZugdU99F+ag8BX7sKc2Z7/s7QtuyuUT8QW8o57DB
	 UCu3e1bZC9lVZoiKIyO4uWNcS72opizzCzZi9f+1kJxpBT1xf9tI5yMJX8AJwuYtlnttC
	 JWVpSf1IkM8HVDEOQA3UY5KHCx6ZmuSy7c7piigpBUA1Vn8WNRXzuNWlZRR6PXR+IBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="wsGa/rsO";
	arc=none smtp.remote-ip=91.218.175.79
Received: from mta0.migadu.com (out-79.mta0.migadu.com [91.218.175.79])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C85F606A31B
	for <linux-cxl@vger.kernel.org>; Wed,  4 Nov 2026 17:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C85F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wsGa/rsO
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MxR3c48AzklxPRyTJpjhZAtl2/Qg2f+G50G0qs7v1Wg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793813146; v=1; x=1794417946;
 b=wsGa/rsO78jClay5d3sxcOBtHBBN7fBmbamLWxfNz/pDSw19IMIKaInaViyCVPHdH/m+QTSI
 J/PJQpPdlQAnuBe2LYF+MOFeG3KwuGMoSHDvAnowVNyWhGn0u59PF0GtB2I5Hp5aolMBM92naHc
 DySQ7WwtxOYvO5Zj1JNblSYo=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9815f4b0805190e0;
	Wed, 04 Nov 2026 17:25:46 +0000
X-Mizu-Trace-ID: 9815f4b0805190e0
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
Subject: Re: [PATCH qemu v1 5/8] hw/pci: Wire SVC initialization into port realize functions
Date: Wed,  4 Nov 2026 11:25:26 -0600
Message-ID: <20261104172527.2172366-3-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
References: <20261104115242.2035807-1-shrihari.s@samsung.com> <360067785.01793792402254.JavaMail.epsvc@epcpadp1new>
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

Tested port capability enumeration and CXL RP/USP UIO gating on q35
at cold boot and after system reset, with the full series on
3c99db7705c1. The ioh3420,x-svc=on case reports an error instead of
aborting.

Also checked the CXL capability chains and USP HDM UIO advertisement
on aarch64 virt using qtest.

Tested-by: Junjie Cao <junjie.cao@linux.dev>
