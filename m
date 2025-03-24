Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A53B1A4;
	Mon, 24 Mar 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834461; cv=none; b=nwN0ssC7xx2hhH4oEcV2/LG5ICZr6S4rZUsAh14gw1aSzCHeUXGOSaeNPgLyKYzYFI0uu7c6rmGw2pRnwlUCTOhFxR/eL7njc62TgzsjLGlH3UhtVQuI5hZSIak93uhzuLamy/F89T1wBHgOgzWFoZhJiN5+QrvdI2mvqH5CF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834461; c=relaxed/simple;
	bh=/rRjucx91ifCHglFRPYOdFhd3kU4du9TzWNb328YWEs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=OIU/bRWqYvQ9CnXkWEamcp4Lr31cQcIN73uWaLKU+tCgKjSn9Q5qH26N1nmGv7pQafs5OQuNrlvStX7LRpldt8A0MPx6BSII0QhI7nQahgTpGkL5OEWGBPDka2kBT+sSyb9R6vUrdnFjioEsept0VpXtO3niU9XY00MUjb9FY6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bIYthxNn; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bIYthxNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742834418; x=1743439218; i=markus.elfring@web.de;
	bh=/rRjucx91ifCHglFRPYOdFhd3kU4du9TzWNb328YWEs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bIYthxNni1NNrGMtMBN4yZXVCA+VCmXcIVuEM+FE75hRirrtu5QpGw10SZvfIy3u
	 PtylrD4161N7xNz4AsWweuL486niZvLl9GtRQj3aGRa0WgvrKFfopAHmvYbtTiLMj
	 /Af1ncCOTPIFbx9/DPYTXYI5I3MnXUo8itnNRUEOGiGBGEKQl0R/AIbZ5hobp5Xj9
	 bLm6M0P0MMo8KMc1AIJFyLFtV9lQ6XKWvmS66s6tJtcd0qIWmJmUWiK2+uyiRGJOq
	 gf5vZsDZy0MxD2bAjv6qdkV1nb6wPsFnG8NkZfKt/HESqrXredfrYQJZmlCdp6W3s
	 fERaYlKDvH8zdZtHAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1tYeNe0plw-00R0lK; Mon, 24
 Mar 2025 17:40:18 +0100
Message-ID: <fca457c2-f0af-4fb8-9771-06916737f9db@web.de>
Date: Mon, 24 Mar 2025 17:40:10 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rakie Kim <rakie.kim@sk.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel_team@skhynix.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
 <david@redhat.com>, Gregory Price <gourry@gourry.net>,
 Honggyu Kim <honggyu.kim@sk.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Ying Huang <ying.huang@linux.alibaba.com>, Yunjeong Mun <yunjeong.mun@sk.com>
References: <20250320041749.881-2-rakie.kim@sk.com>
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250320041749.881-2-rakie.kim@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vxBGvwS+EWZlmP/W7uoetSnf9UKACodThYGYygfRGKVZk+mygbS
 CwF0SCA3f02mHf8S3wRybjPH9CLqmVtfaSIuXSiJ+jzmuKXf0WJCUvUabLrLG6WvgMqAF70
 gRrEifpNTMNgMkmBzve8Itic2FUr8LVFriHQQ40zgkMFGB7bWYXkJEaAVs/AC9l264f5jvU
 78FKWmQPh6/bu38Hjq8bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CS8vjuGqyOY=;Bl6LXBxXiN8N+Uk50ucBm4GLFDZ
 nEQJGuaoAv7iHslz2wf1KzVrid4ay9FW//7ridLaa7XqNRk9e1Wlsl7eUYdgSRgn4E6jdPLqw
 PoTGuGThAK2CS4co8K3MC8NFYCkMRAwBHcA1bC/RFdeXGVZHaDY+8beFbbNz+w8sztCy//w0k
 1DDLj3KtoxkJboeL+6bIchcsHRDXfB1/TpNjQBrauuiPsPblxwE5MCizlzHyBcWipb8o8sRvF
 r8B/ReOAjlqu6gEaR2FbaopBhP/4S+vmWACkUcnXg0AZhs2w2TykNWNK7RvSs0orwEHFfx4dd
 4dv222dDMbJuOuEpm13dMhqL2k2ZnLEpu40BgCLGv4VGUwYEp77t2pLtFwI9h4kLIa5jKwLSh
 bIoy9Nbg07o/iT0qkBhXXZTEtcW3JN9t24uS1V+aHCEvnYWpshSmdK8+pSwIs/OhCdpqk6lq8
 uUfxiTKASkx1B0i9Z0dc6zs5UgnEF8BiaaSON8K419G5JiUbZpNWOvM1BMiXIwg+K5OI/vcf1
 o/bGR1d09jQBcQCOrVNdSJ5Tx8Kd001ygGFftQXbgdUHV3n/GVqsUYbcRMWZ84TNrL0neKWjg
 cwALEzRJATiKzLKdcsti8JK/gbKGwDfgz7TyxsZM/Aq8XIOZ5zrvE1cEU4mYRYm0Z5a9+XiB+
 pfRjPyBRWBG3XIyXl8JDY0Vdo17I0OQWqHaYDmhK/CjeNPfjQXCQF80MKhH04IcjN3gje32J6
 qQYZhyscB9dOvm0bim9LXC3krMs2AD5y63VRw3CQ/6U5X1v+Qc1kw47ETIsoLXg2k1l3jjVcH
 9IUGtR9Zw/+J6pVxeyajthdlnmm3ISPp3QhCVPMpu8s5ysJwLhCZDB5SSHjBOEcI1xhzjd8nQ
 tH29+h+41BWdbQUozPaewEe2c2XoHUXlu9uxW1SYktqehcXM6LBoSoGhVCx6LFz61ESu0f8Sv
 t+CK4e0439vPHD7qPQ2ID8DmplS44Q28B0COzYbn9W+mQF3qYIjlq0pvHdyQCOAsff9BBYAeS
 lnstsWpECJJNsjvPWFxGMCsU89fjv5cdTVRTkIvwug1cJT0L+P3SDbJlzbtm9dJaEUKinT0ne
 UWp27HlM2pLJe5lI0qY8CX6XQfb0AAxX3xuCXn7/UItjAPI1YUNhxmq7xd0uv0GUVRTvDbG16
 5kzFu/i/DCenoU/dPC2hqjNZxgVwUQw6DWz+JFPLpwNcXUOIAe3PIrbMvXhY4V+OXlCBuGHr5
 u7d9h/i3gWCWdSakCsGN1dKAjMVvAHPAG5p7UdsP5IMJ//DZQ4gaiu/CenmCrLkxwE4qQ2I9E
 th0ZyAO8KkFaVQ0Q1scPXhvui22ElRUcxuRvzRg9/rof1Brut1KVPQVxZhNGZdkHlHr2oYyzd
 9plwUimYymvOdeKcONMixv2Zp0K6FuIpAj1bmjITdkdbIkPAWINWcntcHaeIs8PGG93wEZYtT
 reCZtZSPncqE/4OFbWTto0TedlyLBwHJKq7D6YLeMEi5FxVEz

=E2=80=A6
> This patch resolves the issue =E2=80=A6

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94

Regards,
Markus
