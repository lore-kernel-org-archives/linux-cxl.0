Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C703282FA
	for <linux-cxl@vger.kernel.org>; Sun,  1 Jun 2025 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748815458; cv=none; b=IbB2I9g9k3WEZcBp3KbMenW8NvyAVYggfdjtDip2fq6/OqqoyYxBGw9UdE7luH77BpJtDb4/17/xTENdDBa2Y0kfXVBI+Sq+7J46Lv+ilZLbvJNl74Y2XXrh+VUctnUN4xFj7FZefTIUqL1UOlmS0/77OhFl2xIF7DYkObpdo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748815458; c=relaxed/simple;
	bh=LKxxUhJ7Ju/VyGFoIOvXUwA7scZKoHcsNwCaeW31VOw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=VCdPAaT5aOwgEqCnO+zcyUZ5dEybOU7VbLTs/ziq1M6PfiMhkWgMi8EDD+Ts1r1R9uZu1ZSxUWO8dPf0Qn2OjXA67rxdLqqGttIq/56+c3wcp6+ixWirm8HuKFreIRUFmFaJUGol7o8qjxQ/bAKT4wVLzeyqbmnesiB9jmwEvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RPOi6aC8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RPOi6aC8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748815449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LKxxUhJ7Ju/VyGFoIOvXUwA7scZKoHcsNwCaeW31VOw=;
	b=RPOi6aC8gPwk8a3gf1P7W2B8r1snjo+IvP4iplqBwLg3c8McyFSjTnJ4DeFCDuS2/WhJkk
	//VqfqrTTJzUw1qEx6VSaqBLmZ2t0w7piR6ruL5+L7b80JHBxTXM8zLhtVQjlzgkdWqFhW
	KwcncaorLtBMWBKcroFOp8f44zpMr3I=
From: Itaru Kitayama <itaru.kitayama@linux.dev>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Kernel test setup
Message-Id: <0A157714-A431-4AAB-A4E6-DB0C32DB73E9@linux.dev>
Date: Mon, 2 Jun 2025 07:03:51 +0900
To: linux-cxl@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi Alison, all,

Your comments cleared up my incorrect assumption (in order for meson =
test =E2=80=94suite cxl to success, CXL device emulation is required):

https://lore.kernel.org/linux-cxl/aC_rWIc9TY5F2wGf@aschofie-mobl2.lan/

Now I wonder, thanks to Jonathan=E2=80=99s QEMU series being proposed to =
upstream, if it is possible to test the CXL =E2=80=9Cnext" kernel in a =
fully CXL devices emulated environment be it on arm/virt or q35 machine. =
What do you think?

Itaru.=
