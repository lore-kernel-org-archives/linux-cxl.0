Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12479C1
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 01:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710467576; cv=none; b=PSDdeuzGif20hlazMULtsjDI1/Eouw59jgEjiZ41JGOvufB9+fXrAneu5qVIIm7rE8WG0/CM/USCUT9Df5AwxxW3tj2WfkIDSZSJkyNmGhpcUPL+x6tclzASKPMVOssnljFhPJ8A5nDDIDZbNLllbrrtqQJ/dus8ntd64djyK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710467576; c=relaxed/simple;
	bh=HBRNufJs0i2GsydbQFxlFVoW0ETNrpxYRLC7X/Bj548=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTmjNyuxJxoxhQwLkhUy7u2N+JKI+NBw++49prQSa2I3d8Pm+iBWVJ8IXWb8PQVUgKWaIhWOeHFSAOohRbCTMbTim0atwPdLxMt0wM60BmEMMwA3DY15oieTZhP25FSIWQR7bEbLB5xzA8AEl48bUZPNRaU0frulay9em/+Mfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHAnHoqfNlUTaaDQ--.1751S2;
	Fri, 15 Mar 2024 09:52:40 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwD3aEHlqfNliS8AAA--.98S3;
	Fri, 15 Mar 2024 09:52:37 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com
Cc: dave.jiang@intel.com,
	fan.ni@samsung.com,
	ira.weiny@intel.com,
	linux-cxl@vger.kernel.org,
	linuxarm@huawei.com,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v9 0/7]  QEMU CXL Provide mock CXL events and irq support
Date: Fri, 15 Mar 2024 09:52:28 +0800
Message-Id: <20240315015228.307512-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
References: <20230530133603.16934-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwD3aEHlqfNliS8AAA--.98S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAFAWXzUXsAmQACsi
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrKw17XrW8CFWxWr4ktFWfGrg_yoWDGFX_uF
	4vkFZIvw4ayFn8Ar47XFW8W3y3J3yDu3y5WF4kJF4Iyr1fJwsxGan2yF9xJa43GFW5Xan0
	ywn8X3s2gw1xWjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

Hello, Jonathan

When during the test of qmps of CXL events like "cxl-inject-general-media-event", 
I am confuesd about the argument "flags". According to "qapi/cxl.json" in qemu, 
this argument represents "Event Record Flags" in Common Event Record Format.
However, it seems like the specific 'Event Record Severity' in this field can be
different from the value of 'Event Status' in "Event Status Register". 

For instance (take an injection example in the coverlatter):

{ "execute": "cxl-inject-general-media-event",
    "arguments": {
        "path": "/machine/peripheral/cxl-mem0",
        "log": "informational",
        "flags": 1,
        "dpa": 1000,
        "descriptor": 3,
        "type": 3,
        "transaction-type": 192,
        "channel": 3,
        "device": 5,
        "component-id": "iras mem"
    }}

In my understanding, the 'Event Status' is informational and the 
'Event Record Severity' is Warning event, which means these two arguments are
independent of each other. Is my understanding correct?

Many thanks
Yuquan

