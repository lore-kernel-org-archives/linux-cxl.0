Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.248.84.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303819;
	b=fbI+1tZ+bTQfCSPfHkIAchhXjA44dPjmMRm8z3HIfgZBQbw6tG5j6CucN/Yuwz6x2reh
	 deEoalN/9e2Qfa36KdgZR8mAOaTUAQ2EMe9IZTxeokKJQZCjfROJuGRNkeQV5VvyatBq9
	 KlTlH/CB5lr7KkZXs8m0hQKwCpf4kUOXrds0H7KQGbzze+IC45nEARS9ag3D15YqSuUFE
	 2P0nYiImI8X+p7DpsY1YLZh8rYrvSFRfxQc4XtEgs4xzqgKmayRNpk67HjCNrbyWtchaJ
	 u+PoNKCqskPtDFUa12eyQqrPaHOAsTBvR7Obs0BFiDV9SmxNbax6s7XT6jraPIs7pJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303819;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pem4F37jr+m62nfwl+Tul2W94Jw4wrP+rdqDhPkYgoI=;
	b=r9yKrzjw+XzV9DFLOlVUODxdJ0qGnzQt+ErQQ6MJoIe9fQ6wb9D+Sa+7JKAmn3s2q/mh
	 hWnBNECCLH/cyN6XaAPv59FUFT/Jt5yNM2+Xxu+JtXmNYV/ZmDrUJ6v57bBQmfRS6eSwF
	 dlFXv3QyiIn+T3lFybPtwFXHA3PTsmQilX/QHyOxvFb0aXTvmR+nM7cpWOg+5d8tN7HnE
	 /pPNKlotsCRfAiYN8BjtMLV58RN4QSB6sNV+ccBCMhb0VW3s8vYe7kxJcEE7935nTXL+O
	 eQJH5SbP8ptWIp0vPTo0/FOGV0SaZFQfCv3O9M3jk0/mRZqyIH6h0TVba21XUYi7iqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tls.msk.ru;
	spf=pass smtp.mailfrom=tls.msk.ru;
	dkim=pass header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CLFJoeGa;
	arc=none smtp.remote-ip=212.248.84.144
Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01B1606B14B
	for <linux-cxl@vger.kernel.org>; Tue, 10 Nov 2026 09:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E01B1606B14B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CLFJoeGa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1794303803; bh=PsigdxoagA2gd/IarfS8ZqLG26MD1xjQVzsxT0dtCwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CLFJoeGa+4F6AVyK0fZ3ZGEDgn96Hy7y4Q37CRsK4YetCIbOHVZSJLJtDxp0OSgOY
	 5d8rEr08eJeoKg2Wn6mKSbU7aV3W7Xw4O9SA18xB23gPL+N2sU7+/cRALNnVP3Yq8g
	 wlSWRYIa1P+64dMrws4BOtiveKF6Prxq+r5E8fhvlDIOEfmKIcnym/6Z+U8adgk+dg
	 eI+MqRUpFU2uWdwtz2WoDq6P5RW9fkta3wzSx8VhWQyLciI3H97FQ8KFB9FrcFJ+Z2
	 0WE1L61LumoKDBccvcTIxcvK65bi0oCXO+Sk9wlawAE50D9qjza+JBVaGUYbxmzVRN
	 eC9NuoPAIf4AQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 6B4B31E50F6;
	Tue, 10 Nov 2026 12:43:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id 51BF4457E0C;
	Tue, 10 Nov 2026 12:43:23 +0300 (MSK)
Message-ID: <25ca13a6-0305-40a3-b0d9-4f468aaa682c@tls.msk.ru>
Date: Tue, 10 Nov 2026 12:43:23 +0300
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-10.0] hw/cxl: free the CCI background timer on
 Type-3 reset and exit
To: Junjie Cao <junjie.cao@linux.dev>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, jic23@kernel.org, anisa.su@samsung.com,
 mst@redhat.com, philmd@oss.qualcomm.com, linux-cxl@vger.kernel.org
References: <20261030124417.1066423-1-junjie.cao@linux.dev>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20261030124417.1066423-1-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 15:44, Junjie Cao wrote:
> ct3d_reset() re-runs cxl_init_cci() on all three CCIs, and each run
> allocates a fresh background timer without freeing the old one, so
> every reset leaks three QEMUTimers.  ct3_exit() doesn't free them
> either.
> 
> Upstream fixed this in 259b877eac36 ("hw/cxl: fix timer leak in
> cxl_destroy_cci()") and a004df0be51f ("hw/cxl: destroy primary CCI
> before re-initialization on reset"), but both rely on
> cxl_destroy_cci() and the .initialized flag from 98cbac128f1c, which
> only went in for 10.1.  Add a minimal cxl_destroy_cci() here and call
> it before each re-init and from ct3_exit().  timer_free() takes NULL,
> so the first reset needs no guard.
> 
> ASan on v10.0.15, 5x system_reset on a paused guest with one
> cxl-type3: 720 bytes in 15 allocations from cxl_init_cci ->
> timer_new_ms before, none after.  cxl-test passes.
> 
> Fixes: 221d2cfbdb53 ("hw/cxl/mbox: Add support for background operations")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

Thank you for all yout work and for helping with back-porting this to 10.0.
I haven't get back to you at the time, correcting now :)

/mjt
