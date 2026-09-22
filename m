Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF213CF82
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 00:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037589; cv=none; b=Ky3Yw4Ic4axzdFqOGMHKQtl8NlGlmVGtPRht5LC8sJfEGAAyS6uPotjoBHd7WxCvzBIKH/boM/BwFrKcqYAiuc1dA03q7mEWSWufu4URULYZxn9EI7RgQKWzeiRlCbMc8i9JfG6xTSg3Xwz8qah5P86Fv5R7qKK3JhJZVJQIJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037589; c=relaxed/simple;
	bh=9SdDAD95xMYFQ4gfCjrZDNf1uTiQ0xw1LMY2aBSgE2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snKFr1ItQyK8cg1ovctD5W2mOb6xaACpCIKJFhcYHcPudWi41vmFfxQK6qiAcCvSy/nQ02B5brYxbxtkyzSt7FrfrSTbhCDInQw7BDcpB42zkNRg3/+S/Qm2TixYZ/Aut/d0ZHbay2/HHUIkOtUB+ZdFdmQgKS7VIprkIPW4U2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxG0XaJL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxG0XaJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FA41F000FF;
	Tue, 22 Sep 2026 00:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037587;
	bh=50nU5Tf/W6+TzXP/ktV4AFtIrpd6f4nmN4oL0ztCO6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bxG0XaJLpm/aXAimXYdvFiz/HKzumzqEI6WtmKBvfa5ND+z1N/9hYELj8234sWiHG
	 9IHG3aSqHDIzJnNCe2QiRy8OwkObbMhLaJlaFQNMNMhbjTazUeR+cCnu/6+jwTVX0z
	 z1nkFH92wZ0xEXcJ0LQ3Z46EY8h4uR2MIv8etDgbtingkf8aU6nyw30qBL2NSyCnnJ
	 Byw997+zzAlVnG95A/3Mf1LU+NAm33qcj1+JMBndvZKTGNS5yyMUjzaaubkhyxbn08
	 CX13S3BjPoHWoQGdXTqpl8EWE+2RStdVHqPce1GNv3Y8l3a5N1ZHPtA0/1PfrhTn8Z
	 rMdhrIH1f8Frg==
Date: Tue, 22 Sep 2026 01:39:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Xu
 <peterx@redhat.com>, Junjie Cao <junjie.cao@intel.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-cxl@vger.kernel.org, Jason Wang
 <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@oss.qualcomm.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@mailo.com>, Lukas Straub
 <lukasstraub2@web.de>
Subject: Re: [PATCH v5 2/7] qapi: convert remaining simple intros for
 cxl.json
Message-ID: <20260922013942.0abc8165@jic23-hlaptop>
In-Reply-To: <20260917194614.549584-3-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
	<20260917194614.549584-3-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 15:46:09 -0400
John Snow <jsnow@redhat.com> wrote:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
