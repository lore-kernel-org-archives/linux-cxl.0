Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D895610F
	for <linux-cxl@vger.kernel.org>; Mon, 27 Nov 2023 01:59:37 -0800 (PST)
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBXXwuFaGRlod+eAA--.32743S2;
	Mon, 27 Nov 2023 17:59:33 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwCX3c6CaGRlqFoAAA--.474S3;
	Mon, 27 Nov 2023 17:59:30 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	dan.j.williams@intel.com,
	gregory.price@memverge.com
Cc: linux-cxl@vger.kernel.org
Subject: Question about the boundary and difference between System Firmware and UEFI CXL drivers
Date: Mon, 27 Nov 2023 17:58:30 +0800
Message-Id: <20231127095830.2101688-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCX3c6CaGRlqFoAAA--.474S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWVfpskEiAASsG
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Hi,

CXL Memory Device SW Guide [1] rev1.0 2.4 provides little 
description about the difference between System Firmware and 
UEFI CXL drivers. IIRC, the UEFI drivers are part of system 
firmware, so I am confused about the boundary on them.

I greatly appreciate insight/help in this regard!

Many thanks
Yuquan

