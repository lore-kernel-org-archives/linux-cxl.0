Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCFB22638
	for <linux-cxl@vger.kernel.org>; Fri,  8 Mar 2024 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709863325; cv=none; b=h9O2plZPXTp4QRtqs/YoklInGBXEf3BOMZlTtcVaPGsH8v0N/k0k+/1SKPKEwyyJcO2YCKmPD0FHYd/zjrp+n9HqszuSBud7q9mdYdscrwUIh83XrSMx4RovuVuoQ5PMgi4iGpr9TusR5sOTB+xRMBMZTDGFQu6gMx3Tj4/9xwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709863325; c=relaxed/simple;
	bh=850tsyXOWcmKqMm00tS48yJNpsEgc8y7e24zreAtiIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mys5OCwO1W3xRMqzjhQhkVpIhKNAr0m+MPNEQH9L+bnkGODj4jDp4jDM5QBDKxlSsgXORpjiIy8dzlI7mPtl83CrUQcY8r9Msp+qhVpDyLrBqYiVPzDHRVQ9SOOQDBHoBLnPli/rIuFaZskGZT0FEkjcEArgVGmz8IsaRIC+jsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3f3uLceplXljtCw--.49245S2;
	Fri, 08 Mar 2024 10:01:47 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDXCkSGcepl0icAAA--.93S3;
	Fri, 08 Mar 2024 10:01:42 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	Terry.Bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Enabling internal errors for VH CXL devices: [was: Re: Questions about CXL RAS injection test in qemu]
Date: Fri,  8 Mar 2024 10:01:34 +0800
Message-Id: <20240308020134.3146734-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXCkSGcepl0icAAA--.93S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQASAWXqFuMAOAABsR
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

On 2024-03-07 20:10,  jonathan.cameron wrote:

> Hack is fine the relevant device with lspci -tv and then use
> setpci -s 0d:00.0 0x208.l=0
> to clear all the mask bits for uncorrectable errors.

Thanks! The suggestions from you and Terry did work!

BTW, is my understanding below about CXL RAS correct?

>> 2) The error injected by "pcie_aer_inject_error" is "protocol & link errors" of cxl.io?
>>    The error injected by "cxl-inject-uncorrectable-errors" or "cxl-inject-correctable-error" is "protocol & link errors" of cxl.cachemem

Many thanks
Yuuqan

