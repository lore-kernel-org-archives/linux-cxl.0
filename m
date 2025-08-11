Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437411BD035
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910393; cv=none; b=sGbZMQP2xhTWLMHuyFmF8WtTfX6A0evB77rGWGDKBdzUaF1YV4UDHL/NbO3aMEjBgyDCJvPHYb3OLVW0pWHZ3vqaDR4bOWI1UBYcLPMNEiE4R5HVk6219reYESkOq8IvJCw/jeb+zUKc9R0WYvBgYuA+yZ/wkMp17kjrx7o5HTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910393; c=relaxed/simple;
	bh=nGhfAb3lor5Wk9W+qLPQSfy9oVvod9GXu1mJyWSarS4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMwjD5yUIvtd1sTsVGyy8giF7bFeaSONCx9Phj1KAcXa1KHHJ9cpPbog+q//rvE0vA1c07rylHQlN7X3bFgZ9QoobrVp8KKwbMFhiHmbe5FR7yz4YgtFwv5mRorgCmQxNqetJhxwXyJyoKCSbZWKKlBAsCh2UxEdli0fJl51HlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0sFk1zMTz6L5pS;
	Mon, 11 Aug 2025 19:03:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 732D61402EF;
	Mon, 11 Aug 2025 19:06:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 11 Aug
 2025 13:06:27 +0200
Date: Mon, 11 Aug 2025 12:06:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>,
	<dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v6 1/8] qapi: cxl: Refactor CXL event injection for
 common commands arguments
Message-ID: <20250811120626.00003170@huawei.com>
In-Reply-To: <20250811085530.2263-2-shiju.jose@huawei.com>
References: <20250811085530.2263-1-shiju.jose@huawei.com>
	<20250811085530.2263-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 11 Aug 2025 09:55:23 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Refactor CXL event injection to use struct for common command
> arguments.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Very nice.

no tag as this will get my SoB anyway as I'll queue it up for
next cycle.

J
