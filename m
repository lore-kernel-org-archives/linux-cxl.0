Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F902AF0A
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336461; cv=none; b=uT0sEfn5g0zdN8Xjj1W4GGPxHt1lICXSiQNz6I5kFfJb9BptjyZLTZ8YnM5EY1PvCQYZsePvkI/fgydPjI7I4oxLQdMYTHT7BRYngvYJQvSa5/jCQysrr6MqGWqGAKIEgqfbf4EAMcI7C6UgW6Xvzfa2yUQoO1fNUhCJq29vVyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336461; c=relaxed/simple;
	bh=jOeB/Ttfi5E3wbad0Nk5J+qV/IVL/85dayKO6Sw9+jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvYf+Q6HT4v7hJjhz0fgPA/5Kn6YanmiYZ+Hxk2sNTlkFEnSwJuvA3m//VMOXIvnf6DKTTS+yJs+osJg8wTXZxlYjsAHNT2SXryDD4nlcLmEti17bf6LDGGyB+/WtW2AdwgDH/h6A5zx5b8+7on2jZu55RNQbVBz9NK2LWZplzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AuIU+MUj; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AuIU+MUj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713336460; x=1744872460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jOeB/Ttfi5E3wbad0Nk5J+qV/IVL/85dayKO6Sw9+jY=;
  b=AuIU+MUjsHJZBmzlNBEn+qKwRu4wyq9G4YZZKKUJ6WpbpF21ZaipXych
   qBAr3byeGJd2cffgSAQwEeWBiQ1odN+m4SdM4oFFdRizDWufK1iu6meXb
   iUxBj8Rhez71sZcgjbUvZNJ5aoRRtIpoa0m59CFwq+i3BgtnhGN9cb+y5
   F36XJJ+SBqHj8Mi7V7I9m68MIyIMT8YizfzqS5JDc4+NMSjaEbhPk/FoI
   ppfIPUyya0kgwWztJTSzAcuLuuA7TW89KCOn2Icst5gqC3aPRYymd9H1L
   EcKHsaK8UwIe+Y7pSmgkmXmbrsbznGoOztRx5HICDGRk29QT3JESm4vn5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="155820708"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; 
   d="scan'208";a="155820708"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 15:46:24 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C42ECE4EB9
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 15:46:20 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 09C123248F
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 15:46:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A56E200501A5
	for <linux-cxl@vger.kernel.org>; Wed, 17 Apr 2024 15:46:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CEA521A000A;
	Wed, 17 Apr 2024 14:46:18 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave.jiang@intel.com
Cc: caoqq@fujitsu.com,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	vishal.l.verma@intel.com
Subject: 
Date: Wed, 17 Apr 2024 02:46:22 -0400
Message-Id: <20240417064622.42596-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <170138109724.2882696.123294980050048623.stgit@djiang5-mobl3>
References: <170138109724.2882696.123294980050048623.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.005
X-TMASE-Result: 10--4.059000-10.000000
X-TMASE-MatchedRID: oLfcbJd25TeCZTEvplyDNL/HywF9D+dAScHI0MnRcnQtferJ/d7Ab4JE
	j47BCr7iP1EDunecK1e7REX8b2FriHAA9eFj9SfYngIgpj8eDcDp+L+93eAIaCP/VFuTOXUTwWQ
	4ihlkof3hPNzjJM2MWGrz/G/ZSbVq+gtHj7OwNO2oWEe3+NERqbI0kWNjmwyqGK0j4vHSPPcn3B
	ssePE7PCvE812QaQynwGC8e6520fKw0PJt06oJaHpaQl5xviY7wxgWdRvK9Un9g+oMf9KM6Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0


Hi Dave,
  I have applied this patch in my env, and done a lot of testing, this
feature is currently working fine. 
  But it is not merged into master branch yet, are there any updates
on this feature?

Associated patches:
https://lore.kernel.org/linux-cxl/170112921107.2687457.2741231995154639197.stgit@djiang5-mobl3/
https://lore.kernel.org/linux-cxl/170120423159.2725915.14670830315829916850.stgit@djiang5-mobl3/

Thanks
Xingtao
