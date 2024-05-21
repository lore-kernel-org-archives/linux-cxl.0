Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DC53E31
	for <linux-cxl@vger.kernel.org>; Tue, 21 May 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280781; cv=none; b=dRbWYR+UBzkYqdu+J5CqaEF127U3Nq6p+FzBBcJcT1OgT1CJAxyv+3SBJBMWcuHOZ+uNYmM9MSA3iLr73HXoFuU7/f8vwSgqeyiJABFBSC3xe8Dbo3V5RCD/drFYNxYiOdYVkEDJQqpt1+QaPFwMj3zmnYA7k/+d9r7gscS8GKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280781; c=relaxed/simple;
	bh=WZfzY7/B8Kb6X6RU5RWmn6EXldoVQxxEjAloNaCjV88=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=SY4JdNpK/mLkJwOpJp93aKYRIRzyTA1cJ90s/bfBcsJMOaVKZTESLv02JzrGU/M7xnMW5DiBqBm8nymVUsZHgY6cdOIfQis71k/VxBHqkJeRewcRieLJFQgg9Tk+NOb8UaPAasMt+QLAPsaA4MAZxLWuE/JvrJceXD5VbDQpLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vk77M5Lrkz6JBr5;
	Tue, 21 May 2024 16:35:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A9D84140AE5;
	Tue, 21 May 2024 16:39:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 May
 2024 09:39:35 +0100
Date: Tue, 21 May 2024 09:39:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>
Subject: CFP: Linux Plumbers Conference 2024: CXL microconference
Message-ID: <20240521093933.000020e2@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Dear all,

This is a call for proposals for the CXL microconference at this year's LPC
in Vienna, Austria (18-20 September). Submissions are open on the LPC website,
just make sure to select the Compute Express Link MC track.

https://lpc.events/event/18/abstracts/1771/

Proposal closure date: July 5th. After this time additional proposals may be
accepted if we have space, but scheduling of the microconference and potential
clashes will probably not be taken into account (so you may need to be in 2
places at once!)

We will try to squeeze in as many topics as we can, so aim for a fairly short
session (c. 20 mins) and remember that LPC is primarily about discussion
and solving problems, not presenting existing work. As has happened in
previous years, if we get a cluster of related proposal the committee may
ask people to work together to ensure we make best of use of the limited
time available.

As some of you will have seen, there were an unprecedented number
of uconf proposals this year, so the exact format and duration of the CXL
one is still unknown.

I particularly want to encourage new potential attendees.  LPC is an
experience everyone working in the kernel and related areas should have at
least once! There will be a good remote option but that doesn't come the
renowned corridor track.

The link above includes some suggested topics, but that is certainly not
meant to restrict the scope. If unsure drop us an email.

Feel free to reach out if you have any questions.

On behalf of the organizing committee looking forward to seeing many of
you in Vienna.

Thanks,

Jonathan
