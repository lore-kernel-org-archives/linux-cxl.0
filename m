Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195872;
	b=ZJtmak7dDOMyu8syo11TpzYX/V73lnQLwtjrt+Lnooz/hzjDNwKlW+e84BP+yqYVN+w8
	 zpxCMcGoK/W5lWSmNh8wbn6gO0pUhVb4G4Yck9xiJQCDhzdsXDGldKKi/dI8gS1wLt3My
	 88Qlfi4UeTstWqMY/HzDQIegGNWkSg2tJM5XpsIJF6wSrN/qqe+Sa2dM7oLTSg8xHuJhC
	 MWwE4Neu2KAZuIMPJ9UI7MUBM6m30aIVdhfoKDCS/xjZjnabjYnz75TlYEk107G9NEL3N
	 dHIxYUJfT962J0sx4v8j4ZYaQCOFtWR9w5EDb/0h/Ksu1pjVmMz5iOF3hu3AyDS3VcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195872;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=JTiv2GRYKop7vCx/gXindWSFmU7+GmHnHjp+oJDyjUQ=;
	b=k8MUIDrZYBfo+7V3BWbfFriu8XrTINRmKWXSHFTJrk+JVQUvCpTEYhxVEmS9zmMSNRgr
	 u/3NurpVup65Abit0LkSm3cDczhR64D8fnCsD3zq1MlBHt3peNJjxXHoyzFhs1hRbauXQ
	 RwmWyuWWid7SUnVxEKBG3Z6CUfI7xkjMeqUsTjR9A94sZYCHb+klKzOjPLcuBhYnr24v/
	 5OzsVG8Ij3P+pn3ZUCTe6CCB1CJ4xFitsDzYM89fDQISaKRJc2VLSVyNprugVAHOmM0g7
	 YLNehgmtBwIBRSIPk0UeYyBwvarcyebrAq10HrxOmZjWwS+yVXHvxgP0HNzTfzwZqxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UL182Ymp;
	arc=none smtp.remote-ip=91.218.175.95
Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE6606A322
	for <linux-cxl@vger.kernel.org>; Mon,  9 Nov 2026 03:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EE6606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UL182Ymp
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JTiv2GRYKop7vCx/gXindWSFmU7+GmHnHjp+oJDyjUQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794195869; v=1; x=1794800669;
 b=UL182YmpeSX6nFVbBsJ7y8S/IyQUXmitlzi+JbC5w2Ptgjh/cWL19fCg1j4IPVm2/p8G8A3e
 Zz3G2ydotNN5QvKRbPqEHUQIojBNTXxOPc1QrQFTI7OMGbxmf1kuKdNvyTzu1IW2fadxFyJ1+Lw
 bRnzGF/XbnueIjXLpDOd5JWI=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id b7f753fb76ab6eb5;
	Mon, 09 Nov 2026 03:44:29 +0000
X-Mizu-Trace-ID: b7f753fb76ab6eb5
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] x86/mm: Tear down the direct map when memory hot add
 fails
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <au_l5MRyDbYfsUVe@chrisdown.name>
Date: Mon, 9 Nov 2026 11:44:11 +0800
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <681A0C48-AA5C-4337-8CD0-57FCB21D8D63@linux.dev>
References: <au_l5MRyDbYfsUVe@chrisdown.name>
To: Chris Down <chris@chrisdown.name>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 8, 2026, at 11:00, Chris Down <chris@chrisdown.name> wrote:
>=20
> arch_add_memory() sets up the direct map before calling add_pages().
> If add_pages() fails, the range stays mapped and any page tables
> allocated for it are leaked. A later hot add can reuse the stale
> mapping.
>=20
> Remove the direct mapping on failure.
>=20
> Fixes: 45e0b78b0532 ("[PATCH] hot-add-mem x86_64: use =
CONFIG_MEMORY_HOTPLUG_RESERVE")
> Signed-off-by: Chris Down <chris@chrisdown.name>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

