Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC423D7F2
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164417; cv=none; b=FobL71gHpMIro7c6+KPx+Dubjmu1vYaSh2AJsV6gWq3yo1mxF1hTnAipp9pw2HzKNc83UvZ5dny6yCUU2wbFpISFhDDJ+GQFz79fFtLE/xEaK9S6eXVsnuSMPh4WRZ0Cww+QeonYesWpPvQ3ODBg8bFA8f0W/M4Fd/DHwlF9xjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164417; c=relaxed/simple;
	bh=JbfbSy6QkKP4khdg5TxVNXJ11BySl0qlThcEVKdIqTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjEYOZlAZjWp5CLwmBKkW1D0KohDlbRul/eS6xylYtKp6K7YX0IimR1wlvS1dAKEfVD9W/3usga6SL6fkX3tft7jR4a3qa9LD0wd+bJ6eCScz7kiEBbzXXDldiAHAuhx6giPYJbAxkN2TLZwZ+pVyUvVHRv8sk+lwwQpBRkdM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnPWGpdctoKlxXBw--.58550S2;
	Thu, 18 Sep 2025 10:59:53 +0800 (CST)
Received: from localhost (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAXe+ijdctoeTQUAA--.17109S2;
	Thu, 18 Sep 2025 10:59:48 +0800 (CST)
Date: Thu, 18 Sep 2025 10:59:29 +0800
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: fan.ni@samsung.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
	rad@semihalf.com, peter.maydell@linaro.org,
	leif.lindholm@oss.qualcomm.com, graf@amazon.com,
	claudio.fontana@huawei.com, philmd@linaro.org,
	richard.henderson@linaro.org, chenbaozi@phytium.com.cn,
	qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ligen@phytium.com.cn
Subject: Re: [RFC QEMU PATCH v4 2/2] pci-host/cxl: Support creation of a new
 CXL Host Bridge
Message-ID: <aMt1kZH+Nlqjb+mh@phytium.com.cn>
References: <20250807105910.240070-1-wangyuquan1236@phytium.com.cn>
 <20250807105910.240070-3-wangyuquan1236@phytium.com.cn>
 <20250917173742.000078cc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917173742.000078cc@huawei.com>
X-CM-TRANSID:AQAAfwAXe+ijdctoeTQUAA--.17109S2
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWjJu34I-gAwsy
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Cry7Kw4DKry8tFy3GF45KFg_yoW8Gry3pF
	yIgF15CFWkJrW7G3y8ZwsxZ3WrCrZ5JF45Jry5KF98Z3Z8A3sIgrsrKa1a9a4DXr18Xw1v
	ya17Z3s5uan8ZrDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Wed, Sep 17, 2025 at 05:37:42PM +0100, Jonathan Cameron wrote:
> On Thu, 7 Aug 2025 18:59:10 +0800
> wangyuquan <wangyuquan1236@phytium.com.cn> wrote:
> 
> > From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> > 
> > Define a new CXL host bridge type (TYPE_CXL_HOST). This is an
> > independent CXL host bridge which combined GPEX features (ECAM, MMIO
> > windows and irq) and CXL Host Bridge Component Registers (CHBCR).
> > 
> > The root bus path of CXL_HOST is "0001:00", that would not affect the
> > original PCIe host topology on some platforms. In the previous, the
> > pxb-cxl-host with any CXL root ports and CXL endpoint devices would
> > share the resources (like BDF, MMIO space) of the original pcie
> > domain, but it would cause some platforms like sbsa-ref are unable to
> > support the original number of PCIe devices. The new type provides a
> > solution to resolve the problem.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> Likewise, this looks fine to me.  If the SBSA maintainers
> are happy with the approach and PCI folk think the more generic parts
> look fine then would be good to move this forwards.
> 
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>

Thanks for reviewing! I am very much looking forward to the maintainer of
PCI continuing to review this patch and providing relevant comments.

Yuquan

