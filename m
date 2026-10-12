Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534F48EBC1;
	Mon, 12 Oct 2026 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815246; cv=none; b=bJJubD8UZz66ZcYRkDm0utUYVpUNEWgunWq45i+juo1P4PgiDFOYJeYjpbeAGjznl3m7F+p0FreJfunc6thPBBHkwl0bd6OwY53OXWVUkMGZ7VZtgdHiL8yTR8dp1bLbx/ipypWugFdKBi2G1AjX9KEISC1Uon08pM8FZupoUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815246; c=relaxed/simple;
	bh=WpQuDBiCl+JkZB7wvzf2ljSF+awDmdv9CETj1moBpo8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=agI/rjmmw2KOwMLKbIWIdoFWDGRnq8FHQJEP7oATO8cJmTGKyv+7UTOvTyszMpB+z9rNxlrasRXa5Fgp2bltcc7jcDSjVrxZUhQrVPUYLkxrgCOlOq1+neDpq/ABdc3tEpVN/fjvn9DvwOWyKLquadJR0GOaECrBx1CBwPE2d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=q2ipHhOK; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="q2ipHhOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791815242; x=1792420042; i=markus.elfring@web.de;
	bh=WpQuDBiCl+JkZB7wvzf2ljSF+awDmdv9CETj1moBpo8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q2ipHhOKKZlUw8C2gfgqoYpp/Dg7pJLNt1t234TsF2zvdM2+oThGyoHxWXwDxkTt
	 iILFH6EXMXRA5X9FIawiW1WC0jod7K9KeGS/OjMOgCMw/gPMKiINYGG029ixOc+mV
	 qCCiP2aOXuWktzWZ+ApmmcnFYn1tpf1QEiYiQlSvAgu9j0BRwB6ixGwPdBtCvaJDy
	 HhMtf1NfFD9UZsHz/HauAeg2o/9CN7YgOQF3Z0v98G1EbI27hJ8t0YnXDQB0NkVmV
	 wirG05Dg9Ktwt6PLxKbxK/PeilQv/ogUKVGOZc/IWLAjUyFegLRMetovOnG3x9hvl
	 NnUymcyX96rUIIV0Zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1wZxub0ogB-00xzCG; Mon, 12
 Oct 2026 16:21:42 +0200
Message-ID: <c37fdba1-0fd0-483e-bc0c-1767f2cd32be@web.de>
Date: Mon, 12 Oct 2026 16:21:39 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianyun Gao <jianyungao89@gmail.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alison Schofield <alison.schofield@intel.com>, Dan Williams
 <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
References: <20261011132017.31131-1-jianyungao89@gmail.com>
Subject: Re: [PATCH] dax: fix dax_core_init error return code
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261011132017.31131-1-jianyungao89@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nu/EhIBzCsaE8qYl9jkWds6saI5RuRBB7RPjMBv3/YGqk3QxfMq
 BlWA8lARJ60d3V/0MIas7yNHcgVQG9M+5wxs16rXfSz54ocIYHc/OIaGf1lFOp8vc7MviVb
 b0+bUhVIVpQiBKUD+tVimjYFZ8s2z0SK8QvotOR+ef7oRJiwyicIqFJRbbS3qtVOYdvNp+4
 Tj437xwtgjkulMFeapSUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hwxPMwkru3Q=;B1kFm7HVSmsQI7Du9agIywxvJsO
 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

> dax_core_init() mistakenly returns 0 on error paths. Change the
> error return to use rc so the actual error code is propagated
> to the caller.

Please reconsider the proposed need for an additional label once more.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v7.3-rc7#n532

Regards,
Markus
