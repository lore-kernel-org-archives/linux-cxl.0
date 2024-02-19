Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98444C88
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 17:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363947; cv=none; b=BaNLHJEFIYx1acY35kcEMflvOoGqXo3ExSXtkUTtvurff3SxvPae7Fj3lQc9zL1NC7lPWDWFBfhnqsGgU7RU0v6LTIUatxA23tLH4UrSejjqK4c8OqdIG+dngaJ8PpTPl3gxOnZ0n63sEeBCP3PdLG969uhcmZKExelWpg09Pjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363947; c=relaxed/simple;
	bh=yVW5NM+r8f2jP5VpJ9hWEwKkIJZJtFGdrlKKYAkCRKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUo5tWJh0yQtdn/FPvdWDaix561s4RDi0OVxOSd0/5WXCP3pGt3d0QxI5W8OMFrZ6HFOJzLAU3G8UloFZffPXsPrpChYpKKzcW9iHKwWiSCO6KZDPXIR/H2MnQRZZA9DHJm6Vxn0Mdn0izwlQxcjbOclXE3dAXeACMWDBUVMku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdqJB05nKz6K6Dq;
	Tue, 20 Feb 2024 01:28:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 12E0A140516;
	Tue, 20 Feb 2024 01:32:23 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 17:32:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gregory
 Price <gregory.price@memverge.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
	<alex.bennee@linaro.org>, Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <richard.henderson@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: [PATCH v2 1/3] accel/tcg: Set can_do_io at at start of lookup_tb_ptr helper
Date: Mon, 19 Feb 2024 17:31:51 +0000
Message-ID: <20240219173153.12114-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
References: <20240219173153.12114-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: Peter Maydell <peter.maydell@linaro.org>

If a page table is in IO memory and lookup_tb_ptr probes
the TLB it can result in a page table walk for the instruction
fetch.  If this hits IO memory and io_prepare falsely assumes
it needs to do a TLB recompile.

Avoid that by setting can_do_io at the start of lookup_tb_ptr.

Link: https://lore.kernel.org/qemu-devel/CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com/#t

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Picked up tags and adjusted patch description as question now
    resolved (whether Peter was happy to give SoB)
 accel/tcg/cpu-exec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 977576ca14..52239a441f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -396,6 +396,14 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     uint64_t cs_base;
     uint32_t flags, cflags;
 
+    /*
+     * By definition we've just finished a TB, so I/O is OK.
+     * Avoid the possibility of calling cpu_io_recompile() if
+     * a page table walk triggered by tb_lookup() calling
+     * probe_access_internal() happens to touch an MMIO device.
+     * The next TB, if we chain to it, will clear the flag again.
+     */
+    cpu->neg.can_do_io = true;
     cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
 
     cflags = curr_cflags(cpu);
-- 
2.39.2

