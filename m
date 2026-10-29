Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.206.215.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277447;
	b=swFDnmtJmvTWE+S29/QQoU4c8ngFn9WEV2ayUpzyxRlbyZQi+K4JtUhU2Wur2h+vOnBN
	 39O1V1QH/dV3F+8U/p+PlqEtIcfXHLK259dWV0Hnl/ies5EzQGAaeWg6wXZIG4oglGgD2
	 iSb7nweZLJqiOkXJgh2fnkK0XFrhhyrnjhegfoQ2T5HlTSlEoo6Ef3SFD6dFJ2aquj1tR
	 4/coacbWZgDbsl/6SyfQieDvrj8Fssx2RsCDhkIHgPwG1SE35pcK33CU5bWNHxRcvS9RP
	 ym1wNMB/a5m60k2x3Y73ohabdLOFnxWZCxiA+InHseMQvKyuRx36XIGrsa2fnJHskyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277447;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=fhT5gHYEbBem0PJaUDojK3jurWH1XsoVoO3BjZuzUCk=;
	b=0MU5DKiMBbzoyuYxulAiohA/juQvi1ILW78RzMUMz2Nh7/t1+Cmms5OwbMTVm36wKfox
	 wE0hO6SCYYWSh2uwOc3JkccFDaNN7NiC+StYyvcNl/XPj9tC23R+nQr2AUqQdWtg4Rz43
	 5YV3UwVzGhBpjKnYOJPTGm4aDqkaXqP+XrSs8gv6et9b9l0YiY/r8Vt5roDOc3/4lfzxe
	 Tre5Hx4xKoOLLspttGjNvsdAj3vf7q3sI+Hppa1D/Pr8b4RsRwdfFXOynMft9GsDM3vu5
	 8yHgzogXVbWKi4wOAsGsoMM/hsleInzGnFfkWpEkz04JUv/G6+teiAI6/JmLUKzLFyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=T+aD56nU;
	arc=none smtp.remote-ip=111.206.215.185
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6508D606A31D;
	Thu, 29 Oct 2026 12:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6508D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=T+aD56nU
X-MD-Sfrom: zhangyili01@baidu.com
X-MD-SrcIP: 172.31.51.15
From: Yili Zhang <zhangyili01@baidu.com>
To: <alison.schofield@intel.com>
CC: <dave.jiang@intel.com>, <dave@stgolabs.net>, <djbw@kernel.org>,
	<jic23@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shiju.jose@huawei.com>,
	<vishal.l.verma@intel.com>, <zhangyili01@baidu.com>
Subject: Re: [PATCH v2] cxl/edac: Fail ECS threshold read for reserved encodings
Date: Thu, 29 Oct 2026 20:37:06 +0800
Message-ID: <20261029123706.83190-1-zhangyili01@baidu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atjhQTk4k6On7Fcm@aschofie-mobl2.lan>
References: <atjhQTk4k6On7Fcm@aschofie-mobl2.lan>
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
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc5.internal.baidu.com (172.31.3.15) To
 BJKJY-Exc19.internal.baidu.com (172.31.51.15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1793277435;
	bh=fhT5gHYEbBem0PJaUDojK3jurWH1XsoVoO3BjZuzUCk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=T+aD56nUuTFDZOzO1RIJBcEZIJDoTll6f1qVly+X67hkv7zau17k4fb4LQG3xk1eO
	 eFR4vwRuvFK05EUkxvvZjqXwAp+ou2nplwhSowAni5woRFp4Hs11mwd4lY6xKsfxXT
	 C21uzu/bCwkfwhj40Vf7XRma2FgUfN1DE70jiizh8JqB9aIJCO5OvJ7ijrwo6jvnoi
	 4UcqHn+B1wzvI2DmwXhSPS3LZnWMu6nqZyWlcnw4i5gNaFvuHI5dDrf6+x+fxJcGrP
	 o7LoJ392xOIoC9Ozemr/9G0rP6SfVsl+2J2MzztEwbsDQiwASNMgI8x6lALKMXy/yl
	 gfVX+FYkfu9YA==

On 2026-10-21 08:58, Alison Schofield wrote:
> > Fixes: 85fb6a16ad14 ("cxl/edac: Add CXL memory device ECS control feature")
> > Suggested-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
> 
> Hi Yili,
> 
> Thanks for the updates from v1.
> 
> Just a couple of process things for v3. Drop my Suggested-by tag.
> That is usually reserved for folks who suggest the actual patch,
> not folks who suggest changes on v1, like I did. And, send v3 as
> a new email thread, not in reply to this thread, as you did here.
> 
> -- Alison

Apologies for the slow reply -- I only just caught up with this email.

The v3 was already posted on Oct 21, before your email arrived on my
side, and it still carries your Suggested-by tag. I will send a v4
that drops the tag, again as a fresh thread.

Thanks for the review and the process guidance!

Best regards,
Yili

