Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794796430;
	b=ppKnz1zimY7JpmxWkhul7gOAo16Kd8Cj9oPovZkgWXSn9ocEcRSO+oa/aVYOlc63duiJ
	 a4nqOEMpWmrW0Nf/yeLCUiSukYVJbWlf97yqvFnJ7vGYC60RLPvdvM/BUiOLXCCnhfCgS
	 11z87wxEMtuqxJwDesjOHp0D5eqrSOU2J5XenKeUezKgGbfFVJUC3+infvD1SveMqZO7d
	 suCgw5Gu4wcGwIur4BQP1+1ML3VQRTp69ThnxbjAGXbPClF/p2RSujJgM/b1bxdEJkFNr
	 5vfPuVIE/YOyTOgd+9ENzG+zAQEIZ1fDQ+LVo50ePBpa1d05PqbGMh7tjmmC/f8089g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794796430;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=Ti8JYA4Z3TWNM+zPcnTnSa7F5ZqJFQvbSsqIlfWXtR4=;
	b=Zh1lJpu3HjIM1fXC5tFk5ACvPtTfvKEcYkFPlhHTR3MKHztukZ041ciM0EtcnMU49DAE
	 3S22lePMH9HD209CKIoOnmQM+qaD0/ClkhKchgdpdvTEv8HF8yC7xzt33cRlkUFaU0ztm
	 VO+HHrfLbfSDcTVc+6yR++INBK7sA6kfnxHH4kLrB0VyFcQmH2BLZyjmA10jaag5fsiK7
	 vymtVRF16VxReAiBe5400qmq3ARng/+aps8WSRTt+g68dM2eudOFQsii99vM928RRJPTc
	 OBQnf9o67dJXN5qNWHL519R9YRzvwHxIjEqH7HJNUEfCm6Rz2g8WhrVYHZj3oh7g2KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FnJQew4u;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EDC606A31F;
	Mon, 16 Nov 2026 02:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EDC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FnJQew4u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ti
	8JYA4Z3TWNM+zPcnTnSa7F5ZqJFQvbSsqIlfWXtR4=; b=FnJQew4u1jquCMlZ6d
	5WmPSs8k6lH+hADSGHf2klCxtPKHAKbqC4TpbE9HS5kAHkrV3+MliA2Qv/kKyNKR
	dZMbG/3oj8iZ9Gw5aGhH/rvmOQ1oiuUwRXnHn53CSqp6udnsu3Z//vRBJ5OtvUOD
	mspZ2TTlzLLTa8p4zvdE2+5so=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDnT35ca_pqXIoiFg--.2350S2;
	Mon, 16 Nov 2026 10:33:11 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] cxl/core: Create EINJ debugfs files regardless of EINJ init order
Date: Mon, 16 Nov 2026 10:33:00 +0800
Message-Id: <20261116021300.7308635-ping-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261104061256.1449275-1-yangyongxin@kylinos.cn>
References: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com> <20261104061256.1449275-1-yangyongxin@kylinos.cn>
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
X-CM-TRANSID:PCgvCgDnT35ca_pqXIoiFg--.2350S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUogAwDUUUU
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbDAAdN6mr6a2djtwAA3o

Hi Dave,

A gentle ping on this one -- is it still on your radar?  Nothing has
changed since v7, and it still applies cleanly to the current mainline.

Ben's only comment on v6 was to drop the RCH mention from the commit
message, which v7 does; his Reviewed-by is included.  If there's anything
else you'd like changed, please let me know and I'll send a new version.

Thanks!
Yongxin

