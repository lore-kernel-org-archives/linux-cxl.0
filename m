Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691606;
	b=l5lrer5piwsKMzt/gM4Rb7ZivTDVliJvwfsRx7qtUkZIAztHOGcHZXvkQTWAumUH4W8l
	 VpWgTW0t2gquV1rZqhIw3f09rsrnlhqFOUHj24Dk80UWcppMjOe54c9UPjoVMJBr66J2Y
	 4swd+BFNwqiyeihLhZ7CKDw9ZZ7APDPZ1/oOWmkJeSPbOKYUwO5YjCxA1j7E/jwbx0jF8
	 3l6heVjVk8o00R1hCSOHtzYxP8opat45xkt2/OeZ7R+jQ6sbSTpP3Ll66Xjf4kZXpCNd/
	 bchJ4P6SfhbblwFzg/mopeYPNzUtRSvsQxFPfi5rEY/+O1Q9O+ftpj/l2tq02IfDy0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691606;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=QyEzruHSk3PWNRGlXxnoXSvBzuBF1VHW0e91SegwgI4=;
	b=ZvBeWNJjYh4YE4laN/BPJ5zusjEd+gfBr4rzmVGnRek0j9nR0UY1SoEZTNLXBV18auba
	 qTdGfo5pofaV6j/NPjgHtVBxXTQsSFAxvCwUeD6kcr304b0PsnBEaU21f6oaTCUKzMn0Y
	 9eTY8lXlpW6taj1TOMJC/5vbTEQUwIZFs2vhdtKX1hnSdEVDSv7I+ITA2CIQnvpCloBGo
	 5fS8PT2kolMI3tvW2QuLZ+nqNcJ+pLip9H9md6QWEvEhN6uWkzAmMV7Vw0vhAwfca4xOD
	 8o/6l8nZydvmb23A/tDrmImr5gFVsYkE+PoT5CmCpBFRtgjBVMvSgO9YJv9WYrWWYlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHqd8jGo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB2606A31C;
	Thu, 26 Nov 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHqd8jGo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750331F000C4;
	Thu, 26 Nov 2026 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691606;
	bh=QyEzruHSk3PWNRGlXxnoXSvBzuBF1VHW0e91SegwgI4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KHqd8jGoK63FBGz6hruXqVsJj0+OR5Kg92zKXvALh22HB3TDrcoyFshXfuUHkjShG
	 X43MCgVG6Ql4ImY/4qE+dBYhOUtvDRdQ5Wev2E9cRKsZ6KE56T5+f0qr/tW6uiQKbW
	 hVaGU1yCLlVKfSlzPravL9m5+aPBHHTQGkVJ8Ux9BezoV6AQkCI3nItKg0iJXcd7e9
	 z3KKWdCcYd2b+f17PRrxM5csYQg9fJ8v5RHyyq6mxVrzii7ig9D4ko62yh1MVahScK
	 B3lfEeMOIyw0XxB7xd7Ep+vMDo6FusSnITcevpn8wBF65Z76U2DPREUVw3v/TSJmiu
	 HTpO4GMb6fWBQ==
Message-ID: <d1d7e82c-a113-48e3-801e-61dcffc4c747@kernel.org>
Date: Thu, 26 Nov 2026 12:13:19 +0100
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
Subject: Re: [PATCH] docs: Fix the name of the memory hotplug online type
 configs
To: TAKANO Mitsuhiro <takano32@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>, Dan Williams <djbw@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125193039.2437025-1-takano32@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261125193039.2437025-1-takano32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 20:30, TAKANO Mitsuhiro wrote:
> The default online type is a Kconfig choice, so the symbols it defines
> are CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE, _ONLINE_AUTO,
> _ONLINE_KERNEL and _ONLINE_MOVABLE.  There is no
> CONFIG_MHP_DEFAULT_ONLINE_TYPE symbol, but five files name one:
> 
>   Documentation/admin-guide/kernel-parameters.txt
>   Documentation/admin-guide/mm/memory-hotplug.rst
>   Documentation/driver-api/cxl/linux/early-boot.rst
>   Documentation/driver-api/cxl/linux/memory-hotplug.rst
>   Documentation/driver-api/cxl/linux/overview.rst
> 
> Spell the family with a trailing _* so that a reader looking the symbol
> up in a .config finds one that exists.
> 
> early-boot.rst also gives the zone choices as _NORMAL and _MOVABLE.
> The symbols are _ONLINE_KERNEL and _ONLINE_MOVABLE, so write those.
> 
> Verification: a build of the tree defines
> CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE and no bare
> CONFIG_MHP_DEFAULT_ONLINE_TYPE in include/generated/autoconf.h, and
> grep finds no reference to the bare symbol under Documentation/ after
> the change.
> 
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
> ---

[...]

>  		       See the ``state`` property of memory blocks for details.
> diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentation/driver-api/cxl/linux/early-boot.rst
> index 414481f33819..be9d5e510f99 100644
> --- a/Documentation/driver-api/cxl/linux/early-boot.rst
> +++ b/Documentation/driver-api/cxl/linux/early-boot.rst
> @@ -34,7 +34,7 @@ which dictate how memory will be managed by Linux during early boot.
>    * Linux Build config option that dictates whether the kernel supports
>      Specific Purpose memory.
>  
> -* CONFIG_MHP_DEFAULT_ONLINE_TYPE
> +* CONFIG_MHP_DEFAULT_ONLINE_TYPE_*
>  
>    * Linux Build config that dictates whether and how Specific Purpose memory
>      converted to a dax device should be managed (left as DAX or onlined as
> @@ -61,7 +61,7 @@ SystemRAM.  This will expose the memory to the kernel page allocator in
>  If `Specific Purpose` is set and supported, :code:`CONFIG_MHP_DEFAULT_ONLINE_TYPE_*`
>  dictates whether the memory is onlined by default (:code:`_OFFLINE` or
>  :code:`_ONLINE_*`), and if online which zone to online this memory to by default
> -(:code:`_NORMAL` or :code:`_MOVABLE`).
> +(:code:`_ONLINE_KERNEL` or :code:`_ONLINE_MOVABLE`).
But combining "CONFIG_MHP_DEFAULT_ONLINE_TYPE_*" with "_ONLINE_KERNEL" doesn't
make any sense. What am I missing?

Maybe we should just spell out the full config names then?

-- 
Cheers,

David
