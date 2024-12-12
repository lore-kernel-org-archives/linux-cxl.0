Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3F92101A3
	for <linux-cxl@vger.kernel.org>; Thu, 12 Dec 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999247; cv=none; b=fzM7iuCe6AFJ+A3skQBmfbppKbjZZXZoW/1PwlzBqCldRvYVXoRPrqERH7k72Una4P/2ljWeEVzkmAW0xls/YOqzu9Vo3ZzUjT0JGMyyZbu2DKym9XSbqdxUymHEbzPRxjDKAlUZVGMVVPDlokiZ5ruYUmaURMGx+e8tzc6mvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999247; c=relaxed/simple;
	bh=/IVlLN1CCEvPcfYuvrOgoPCKgqaDP0ENmFnSw5qg6bE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5s59IhmeuYoBI7uPCZSA5DToppCup0k6eFv/D6KmaH3YhegZKXQjEyTC3Y+6jwMPdnb9K6pd2dLggTj9hV3HCUUVzedrEJPaFzbfsfg3pMhXfdT0wGnmj7mtVkXtJuOaCpADq/pz1CviiHMKDMbB7ptC/o/sfnOMl2mW2N7FbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCHjt6DulpnZ6KSCA--.34253S2;
	Thu, 12 Dec 2024 18:27:15 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAnfnqBulpn+A9oAA--.4214S3;
	Thu, 12 Dec 2024 18:27:15 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: jonathan.cameron@huawei.com,
	dave@stgolabs.net,
	y-goto@fujitsu.com
Cc: linux-cxl@vger.kernel.org
Subject: Question about cxl pmem usage in Qemu
Date: Thu, 12 Dec 2024 18:26:46 +0800
Message-Id: <20241212102646.2391130-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnfnqBulpn+A9oAA--.4214S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQARAWdZ7XkCagAHsU
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Hello, list

Recently I am trying to run some pmem tests on qemu to learn software stack
behaviors but met some problems.

Problems: 
1) Since currently Kernel cannot support GPF flow, could the cxl pmem device
run ADR flow as a nvdimm pmem device? And how could I simulate this scenario
on qemu?

3) About GPF flows, according to CXL* Type 3 Memory Device Software Guide,
the main responsibilities of os seem to set dirty shutdown count and program
GPF TO. Is my understanding right?

Any feedback would be welcome.

Many thanks
Yuquan

