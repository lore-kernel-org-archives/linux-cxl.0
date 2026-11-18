Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965074;
	b=jrn1u4ID34W0SojRXWVmm3wqwYUEsExEzjQgmcsTMoa4YqgK7JJWlYdsg+2d/9gMaFYq
	 mEqN2lowArW+0eLKVjZlV0POGotr9CtbHVb7mhM4nR3GG2ugco/OO6HU8glDblny/p/YM
	 qWYWsD/NmOk5o9+TDKJikcnODpnvagzZlsEDQPVE5mnMeGQLXu7sTsBFK9I+dvmOhmPXg
	 iE7hpZP7H1vORQXhQRdkNIpiNdGrluuglXSSlx8wy94t5RkKG/Qkbi2e8fwg0Fk0wXuWv
	 acIYY3hI7nHNjJE9SfSYgXSyTyoVru8KKFH0gOHm47tqdf/qNHIMPn2j88oq6BxBdSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965074;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=wVUD4AMG0HTk5nXX4SIaUFe4wc7cwNUF2GBpWRtajn0=;
	b=xRoCuFuJgxjagwkk/cMSZund6Qn4GAxu5CUGNLby2yOYL2Wh8SacQsXdM+MAHOsg3caH
	 uFW01StoH9McgCB+aBbfj256rGQ3ZfFCIhR7C3ctuEI9HfmGlo9leWgBFYZXy0T1KN7QJ
	 a/we4AGnwTygTie/rqQJLm+f6kEPlygeSSSZieH8o/sclbPgakxMhIUkKPCm6a2XpD0gD
	 EXupGfoQcJPVXv7kN4HpN9sDmtew8O+mml//cQon26XBgr9G4XdtNiSJh/ha7uHzAgm5n
	 8adufUQY22ApEl3RmsuncME6QH06BBQrl8F50RtxZJILD34jRkMxzmRGI0b/n4a9ryw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="XjfI/O0d";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2C2606A31C;
	Wed, 18 Nov 2026 01:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2C2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XjfI/O0d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wV
	UD4AMG0HTk5nXX4SIaUFe4wc7cwNUF2GBpWRtajn0=; b=XjfI/O0dvQ8JWF6sNP
	ZjXYqMZhQzY4FJBVpZbYb37YCJFQzI09oW301Pm1mqwoYZUd7F+0tOoMz94Eutzy
	BCamHM+jlAA+ZMQbJJ1SFP1Q9f8TLTSK9SCpZ12jCUb++kDbcPGimvrbtyrfn+sP
	c2nVGixX/8PGnMQJnZeii+UAg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3Lj0S_vxq+benGg--.52811S2;
	Wed, 18 Nov 2026 09:23:48 +0800 (CST)
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] cxl/core: Create EINJ debugfs files regardless of EINJ init order
Date: Wed, 18 Nov 2026 09:23:30 +0800
Message-Id: <20261118010644.7308635-reply-yangyongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <26224876-7946-4284-9f3a-5c90411b37d0@intel.com>
References: <1a5ceda1-f039-4946-b8d7-2bc97ed48c00@amd.com> <20261104061256.1449275-1-yangyongxin@kylinos.cn> <avzPbtCq9CedwCZt@aschofie-mobl2.lan> <26224876-7946-4284-9f3a-5c90411b37d0@intel.com>
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
X-CM-TRANSID:PigvCgB3Lj0S_vxq+benGg--.52811S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF1rWFWkuw48ArW3Zw1fWFg_yoW5Xw47pF
	Wagw15trs8CFWIkr4xZw1UAFyYvrs3GFZ8ZFykC343Cwn8CrWSyF9xtF4j9FW8Crs5ZF1Y
	qw48A34xCayqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFkskUUUUU=
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbC-wSiQGr8-iRRwwAA3H

Hi Alison, Dave,

Thanks for catching this.  You are right, and v7 trades one wrong state
for another: on a host without an EINJ table the files would be created
and every access would fail with -ENODEV, which is exactly what
4ed7952b9e87 set out to avoid.  Since ndctl uses the presence of those
files as the signal, the compile time check is not a fix.

Let me describe what I think the real fix has to look like and check the
direction with you before I post v8.

The root cause is ordering.  cxl_core_init() is a subsys_initcall and
einj_init() is a device_initcall (module_init), so with cxl_core built
in, the EINJ state is simply not known yet at the point where the files
are created.  Whatever condition is evaluated there is a guess: the
runtime check always answers "not up" (the original bug), and the
compile time check always answers "up" (the regression you found).  So
the creation has to move to where the answer exists, not the condition
be rewritten.

Planned for v8:

1. Revert both IS_ENABLED() uses.  The files are again created only
   when einj_cxl_is_initialized() is true at creation time, so nothing
   appears on a host where EINJ never comes up.

2. Move the EINJ debugfs setup out of cxl_core_init() into a callback
   that runs once EINJ is actually up: cxl core registers it from
   cxl_core_init(), and einj invokes it right after einj_initialized is
   set.  The callback is idempotent, and cxl_core_init() still creates
   the files directly when EINJ is already up, which covers the module
   load order (einj.ko is a dependency of cxl_core.ko, so it is always
   initialised first).

   I did not use a late_initcall() for this because port.c already has
   subsys_initcall(cxl_core_init), and for modules every initcall macro
   expands to module_init(), so a second one in the same file does not
   build.  A separate file would not help either, since it would need
   access to cxl_debugfs and to the port list.

3. The dport directories have the same window.  With the runtime check
   restored they are created as before for ports registered after EINJ
   comes up, and the callback above walks the ports that were already
   registered and creates the directories that were skipped.

4. On your second point, I will put the check in all three helpers so
   einj_cxl_inject_error() and einj_cxl_inject_rch_error() no longer
   depend on their caller.  One small detail: the !CONFIG stubs return
   -ENXIO while this series used -ENODEV.  Do you want the helpers to
   follow the stubs, or the stubs to follow the helpers?

I also see that the patch was dropped from cxl/fixes, and I take the
point about threading: v8 will be posted as a thread of its own, not as
a reply to v7.

This is only a design check, no code yet.  Does that direction look
right?  If so I will send v8 along those lines.

Thanks!
Yongxin

