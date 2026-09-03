Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C126AC5;
	Thu,  3 Sep 2026 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788394112; cv=none; b=Wp4rMYhrMWWPeM3SB8vNZKRyjpU2YGWKbK/7sPSjeWLbdxFUWjFJm8C2xve6Km/j81z2kcKhACssP0/5w27PCD05X3DhBbaF4PBtfyYBpNRES6zyvseNUMRqm9cPzW5R3pz5ik1woAawl6HRZMKbikvcfRlgXhqHzwKXngC1CZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788394112; c=relaxed/simple;
	bh=4IWgXvoJwCaMjMBvWmnY5yakz7j3ORyKCxeakBXB0nc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q93NqNOYgTS/AC2o+mEJEQIpEjCbfy3+cGGPC16Lk/lXnV428wqhsuSR6iWWpiBr9mK97uylqQErZ5pHjp1EUG2iy7nbAWUdxK9/E7QiHg8kORQnlHR58fvtefXPN3nQEC0+mHxx0Uu9S8EYEcZaZmb12VUZ81JMScUdXI8tVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MIH0ahMO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sZX0gfcv; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MIH0ahMO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sZX0gfcv"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F3F037A0064;
	Wed,  2 Sep 2026 20:08:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 20:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788394109;
	 x=1788480509; bh=eLwqsaFT/7/jsEC3Jwx/ALIBHbXxlyRexC2ts2yKUqA=; b=
	MIH0ahMOnwoISX5iyM7WR6aHJfO1cNLQ+fATckZKBZ8ufW9QMn0MpHUSXg+8yu+T
	aI8sn3aMiG4uDaHod++LLWk4J4pWGKcb8zk0iW5q1iPv/NH7vFgO+G3f4G7qVI/X
	dyQqMMEz2B5fvRNnumE30lzXHt0amcCPZ9Ay2ZkwY6GJIAsS2HkrbL+bOhGNrK5D
	kIubjqcdIFB3C4YwF6lj6MA5d5G8XD1jlixJveKOcFiRg1KWxxiXjVem5//Wkbi9
	a4eijPMu4bi9Exh1htBt+4AOMDlp7IlKdpbJCtiRSaD1JgBIEl0aaJWVkE8hyQub
	Ofgip1Cgb1tLnsUOZ4GuOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788394109; x=
	1788480509; bh=eLwqsaFT/7/jsEC3Jwx/ALIBHbXxlyRexC2ts2yKUqA=; b=s
	ZX0gfcvPgAutlepq0BBWtI3+uAOqcpYBaW0dQ7goiYx/XsLUnAg7ROq8t5CR4x8f
	aONDvpG0CaOpxWrLyrS4gBty8Chw84UPMenankLsMcT7vufKsyh2h2Y4Z/vDfYWM
	HCD6RlsPseUv541y5RrbxYlNh9Zco135k4lFoa473oNXpP8A8B25FcEjf9S4NYhK
	+VrOl1XWOJY3NzPYd4XhQ+rnpltGP19CEInPFIHw0rLCB9eMij/F6DQzbSlB0/OM
	qHAiFPPUVxrgZyaq5e5goidEwovYhntBT/0KWUAAHDnwI/sCkSF9s9zZEkgwFDPO
	WzPw6fLZg8d3iW5qsSsHQ==
X-ME-Sender: <xms:fbqYalTw-aB8OAGT1sO0P7FdEUOVoS2-obUzlwJDuSwcZIDto9BwPQ>
    <xme:fbqYajuBU4uJtQXIf2L-RnZyExTw1zfN8beYxZm_rtVC2BJ0aG2hTCEzGU7FeJKTi
    WSb6M-jd8RNe9raz3BTUyDmbY8n2ygM4MBSKKc86miLLp6FwIJcYaQ>
X-ME-Received: <xmr:fbqYavE3jSaQLnRJ0HP5Uq1vcAroWNhH2Gl7YquD8xJOU1Y33O4SR54asJuu8La6jX-eZr9E>
X-ME-Proxy-Cause: dmFkZTE2DRjhSHsxqDc/IeheCF1GLEJmY0Ce8Hm2KpCOC7bFLbKG6aL7bd0kkdKRJn6wgX
    Jksb66tsv21sAaNmOLea/K7XNcnvENk2I+Mp2/kswqe8VqKyhLY26+lT6Wa3gMAHwF5boA
    8nS+/bXlhUXHs06yyBmumSyi54cLrhpOys8JDtKs0Kc/WW0MpK5k6t2mVmV5qX1CCKY75U
    i/EKPcf5wS3wWu+lr6PkA+947/pG6oGFHvtR18nEIpPdWl9W1nbf3g/2QjxKdiLhKg9WAT
    riuHSNYqARRmIYNqKoc1szuzdBFSCdZWljnUk1ZqP6PVL6BFFdgGc49+aP28HnDjy14GoE
    RajVwc2XteBK3IXKUxUXpLX3PMb32ixOmDr+waiYx79IMRTxwy5ZFJPoiFQU3vnRyclP8q
    zDW5RSNMpaU5zMwb2t5iGuUlINXX2BuqIXI3gpYxjMrfZV+oXWNECdBCugNc+T3W5eU+iS
    Q6KrV2vv5BxteFU1LwZ5Q5D8m2ERYPGbJbib8cxFpYKGJA9auKeE62xotsdZHZw9hj1Vs4
    +b2q6M9zebz19fII1HmLoJx79msKkYJiYgdoiQCG2l713M6PtcY7FqgUpRD9vYrgWOpXRp
    tWf/OH71WPhSzDu2lOi2lPfx4JLNWwXwGlsmFIEvH4SXyDDBsLFAVFAFfIcQ
X-ME-Proxy: <xmx:fbqYaswNMeyx3q2fYWSzltu2NpAtFt_We47KT7ODJMAV4PonuR6pgg>
    <xmx:fbqYah0kXwxhwp62SVPkAnqXKED5WCY-PbAyeLwUkz_1alCr5_npuQ>
    <xmx:fbqYakpVfKcHMkA_WOFAue6hosb2Sew2fnTaA_rzNuyy4y2puoMsbQ>
    <xmx:fbqYamUFb0T2sVqrVPz8L_zw0mUUkdIQKFZt5gUfOGKcwnvTzd-wRQ>
    <xmx:fbqYaij4BAY3aeipq3v7HYZXG2NedsutiLG6VpRgXFNAC-iXNQD_zbGD>
Feedback-ID: ia30e4b44:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 20:08:29 -0400 (EDT)
Date: Wed, 02 Sep 2026 17:08:28 -0700
From: Jonathan Cameron <jic23@fastmail.com>
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 icheng@nvidia.com, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_MAINTAINERS=3A_Add_Richard?=
 =?US-ASCII?Q?_Cheng_to_CXL_subsystem_as_a_Reviewer?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260902235348.3563444-1-dave.jiang@intel.com>
References: <20260902235348.3563444-1-dave.jiang@intel.com>
Message-ID: <8E3BF784-0F86-4591-8599-64A0E0443DD2@fastmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On September 2, 2026 4:53:48 PM PDT, Dave Jiang <dave=2Ejiang@intel=2Ecom>=
 wrote:
>Add Richard as a reviewer for CXL subsystem=2E
>
>Cc: Davidlohr Bueso <dave@stgolabs=2Enet>
>Cc: Jonathan Cameron <jic23@kernel=2Eorg>
>Cc: Alison Schofield <alison=2Eschofield@intel=2Ecom>
>Cc: Vishal Verma <vishal=2El=2Everma@intel=2Ecom>
>Cc: Richard Cheng <icheng@nvidia=2Ecom>
>Signed-off-by: Dave Jiang <dave=2Ejiang@intel=2Ecom>

Acked-by: Jonathan Cameron <jonathan=2Ecameron@oss=2Equalcomm=2Ecom>


>---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 3a19da74d00c=2E=2E25d61ce9506a 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -6567,6 +6567,7 @@ M:	Vishal Verma <vishal=2El=2Everma@intel=2Ecom>
> M:	Dan Williams <djbw@kernel=2Eorg>
> R:	Ira Weiny <iweiny@kernel=2Eorg>
> R:	Li Ming <ming=2Eli@zohomail=2Ecom>
>+R:	Richard Cheng <icheng@nvidia=2Ecom>
> L:	linux-cxl@vger=2Ekernel=2Eorg
> S:	Maintained
> F:	Documentation/driver-api/cxl
>
>base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
