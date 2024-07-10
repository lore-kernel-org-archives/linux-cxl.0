Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69CF161;
	Wed, 10 Jul 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720570075; cv=none; b=O1Nma28lgePfMSJtlZPMLHEnIMGEOKkSSAw2wNOxS4W4FCVRIa5ke8a60jRl1Sj7ybhKNPd6ieYGtSZrmKcaVLT2VkHc/oyLgyw6t350E0tbCoszWP4BuiGDxCmkH+oRKBqRArn/9ECEh+DhTJkUdBOy9h6CkUSjJWu6j9F4atA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720570075; c=relaxed/simple;
	bh=pGy4LxQr1LhB9eaHPJeIs8TK0+uf3RKY15IAM0rqmoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8rk7dIHZax1GFRKMNK6ElfkskbIsV7zdOJ/z7x7Dq30UteP1WjY0k5bLzSQXP3RqkZ1l4l7HR7okFw4f4AOKJ87NVpqvNsJvORRJrgTz2WW0MyiXuj01748XF35gJx3YVrIHstl6NrhcZtz24tiWaMZJk9BxD6McPpqMWDIsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=F/228x4D; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="F/228x4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=pGy4LxQr1LhB9eaHPJeIs8TK0+uf3RKY15
	IAM0rqmoI=; b=F/228x4D3/l2sBB+6T9Y47+UDOmWJSEfxGBsGbJvE2c+lT3iIE
	TrhVxqam+0lYYLFTEJxBg3RmeyPr/N+eUNvNgE5nUuMTL4jN2qu+0mQvpmj0NNLb
	acQG/7RUa50N/aEsxkXjNU7fq8+eelNx0XSXjqIJ/p1NFC+fLxTGLtc24=
Received: from gp-VMware-Virtual-Platform.localdomain (unknown [139.227.253.190])
	by coremail-app2 (Coremail) with SMTP id Nyz+CgD3UfXG0I1moBuqAA--.62945S2;
	Wed, 10 Jul 2024 08:07:36 +0800 (CST)
From: peng guo <engguopeng@buaa.edu.cn>
To: alison.schofield@intel.com
Cc: dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	engguopeng@buaa.edu.cn,
	ira.weiny@intel.com,
	jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vishal.l.verma@intel.com,
	wyguopeng@163.com
Subject: Re: [PATCH] cxl core:wrong value of macro definition
Date: Wed, 10 Jul 2024 08:07:34 +0800
Message-ID: <20240710000734.6010-1-engguopeng@buaa.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zow0Aw+vrXShXv+n@aschofie-mobl2>
References: <Zow0Aw+vrXShXv+n@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Nyz+CgD3UfXG0I1moBuqAA--.62945S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYP7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkIecxEwVAFwVWDMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Aw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjg18DUUUUU==
X-CM-SenderInfo: d2isijirrujqpexdthxhgxhubq/

Sorry, I didn't use the latest code when I checked your reply, so that I didn't see this definition in use.

I just started browsing the CXL related code, and just happened to find this error point when checking the specification.

It will fail when the user uses CXL_MBOX_OP_CLEAR_LOG. So, do I need to continue to update message and make it specific.

