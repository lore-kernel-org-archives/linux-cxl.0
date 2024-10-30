Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4682194151;
	Wed, 30 Oct 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285515; cv=none; b=fk6SChCQZTAzNjjZ7GEoOLAO9f69B13GImYoNqTYVkYFM5rbavQVXzKrSZPhQVRJuuWx6tW9at5LLKjZOsi/gk+jD2ZNFzNgU74WkV491HQADLS/X+5OUAMnQVKreAdnHXxhV8Q5Wn1xr/SdZCIdMzhihFk3GDk3QEGklPGm8io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285515; c=relaxed/simple;
	bh=ySMIDfL39z7RfhOBw+kZQlr5Jw+TjEfT4XWUlkrQitY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sy59/lWYMlqiIJAb+7ikijSVG47nMZ5m3FEi7GFPk84IUWC9Bqy6jGKneIrhJ4Xr26hyYRVSAMwVJoIgRvcbF3inECPAyFMZXxG9k1UOdTerIiqw4zoqmuQNdD5jqOJAzGXk1q7ND8sZIgXUpsU/dnhne/X8THDCbVpE0H7K58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b=kHaPlzfU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=metux@gmx.de header.b="kHaPlzfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730285482; x=1730890282; i=metux@gmx.de;
	bh=B6qn/U2iq1HtEQufXVVEjYdqzFLF7N8KdBVfPWVpjf8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kHaPlzfUDjvsc9qW1hC4CiOvQa9AlPWikWh7OEVPiyzAeJNLVvisr4vGZ2JgQfux
	 nlUyZX/0LEFLQ6+Pjx7gNi646eQB0mq6Qi26XJZQrtoW0m1kdEONUnvMtdfO36bMa
	 DEseyRpL7uaSBLh2WU03bJpJPDh9mWDZOJIGhZEYbUg8UizEhlTtA7yCyJ7E/T+n6
	 7CS7eLOpu+pGvkJrkbsecUVgyRWcf+YhfCgg3FOXSR1P9+JlTrukUa6cJgOWqNPJN
	 ErzXLy8WHSwFUCZLddIhxG/l0moGS8a3xDNmTNv4767asHXBTRMVyIkukGHaPdjY2
	 fBNeThK0EAuJZH6TZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.178] ([95.114.207.188]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1sxsYJ0YuE-00E80s; Wed, 30
 Oct 2024 11:51:22 +0100
Message-ID: <18854680-4ab7-4453-85ff-78351d4d4ec9@gmx.de>
Date: Wed, 30 Oct 2024 11:51:54 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] printf: Add struct range print specifier
To: Ira Weiny <ira.weiny@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
Content-Language: tl
From: metux <metux@gmx.de>
In-Reply-To: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VALWkIbQgdz4Kre0TowjBzMwKze9v87s58H0hbTgNaM6JrIrfLm
 D13G9Qn3oGlW2ADV7Pwuj4LV+lKoNx4nT4zncXWQAK8X/fEqIfsJeoaGLijxzef1cMYvNH2
 COVZ1534REOWwcb/dsFZx+Ac4X5eKo2klYmIS/wjSYNZs+oDPmcljXo5PQtFUVXI9X/24+x
 rnCH5Iea4nlxKkK4Mfi4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o59CQicXyQ4=;fj2WhHkOLSc3PEObbIs6JyeLJEb
 2Ze5nC0/14dsmrww1kL8PbPLfsfT7bldeiTXYsDUewH3MyaqOzUMDDAjFMBIbqAa18h/0aeVu
 to1QEOKjNEZjWbwGhUWb2K2f4lcIhiIO3SzaO0Ac0mwWKF2yZkaxcgkLU7Cr2vKIVCszVp5E+
 I3wfDxQg2HBc+8NzBiNYFAm8B9CHQ+nKSy0cTZlpYzm8NIajNAFkYzI598fbdy0Zv4R3+szFX
 co7k6l7JSrj2KtZVYwoE782OvjML/unRJzeKqK4sjiyq2sEVyAbSEJRZttHYsyoy0STDRGPwE
 tpTgqVbIZkZBwguQjKko3wlQSiFze9laddg3EAsr0QFdMNTD5WQs5Q9mZT86oHewokpf9NLd2
 RDaJsNv0Tc++fydH4I5pHZiDFaOmuOaU06+asdGtQtUS2RHxT/p4f4+08l5Vi/eWpwySOgoo6
 lglZ4HrIG4C0lF9yWeNgHavP9fw2quXV0JnnmU7d/19yXVpfk/jiGO2i0wB6OPmyqLz/e7MJL
 IZKJjXqf5H/jqKBleNRnkbn5n1mCpiAOOdtPmkKbsaPL16b2jz1ONdIYx4mfCAcORydF6f7KN
 1KCVsrmPeqi0fuhFC2ftHCxPqU1c1nzqcQsqISLClMQIctVeLg4LBJNsE89AroQ/kAHKv9Za6
 xcRT4A4qrkrFqmzayjCtbVv55UeubrgW8YpknAhs6cVOLLtvKHzP0dnBCnlWzPZOJGvw6qAwi
 Qar6nitWlLupXRYI76KYGWr1sb/C878oFk+JlFy5LsIn94lhArA7Ll2tMSr3it3ospHTO4kaB
 /wOnZtyMvS7JFf4StbEVIG5LNYKppCeJfVrkSWHJiXFlA=

On 26.10.24 02:46, Ira Weiny wrote:
> Support for the Compute Express Link (CXL) Dynamic Capacity Devices
> (DCD) have grown a number of uses to print struct range.[1]  Support for
> a printf specifier '%pra' was being worked within a large series and has
> garnered a number of comments and discussion.

This is just printing out hex dump of a memory range, correct ?

What I'm looking for quite some time is a sane way for dumping structs
in a human readable form (field: value pairs, using their actual types
eg. int vs string, ...).

Any idea to do that in a generic way ?
(potentially using debug info ?)


--mtx
